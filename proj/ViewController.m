//
//  ViewController.m
//  proj
//
//  Created by Byung Gon Song on 2/21/16.
//  Copyright © 2016 INFO290. All rights reserved.
//
#import "Unirest/UNIRest.h"
#import "ViewController.h"
@import Foundation;

@interface ViewController () 

@end

@implementation ViewController



struct Nut
{
    int sodium;
    int calories;
} Nutrition;

// Initially
- (void)viewDidLoad {
    [super viewDidLoad];

}

// sample code found from: http://stackoverflow.com/questions/32282757/get-request-as-soon-token-received
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


NSString *tokenValue = NULL;
- (void) requestMethod: (UIImage *)imageToConvert{
    NSString *temp = @"saved";
    NSLog(@"%@", temp);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoryPath = [paths objectAtIndex:0];
    NSString *imagePath = [documentDirectoryPath stringByAppendingPathComponent:@"tmp_image.jpg"];
    NSURL *imageURL = [NSURL fileURLWithPath:imagePath];
    
    NSData *imageData = UIImageJPEGRepresentation(imageToConvert , 1.0);
    [imageData writeToURL:imageURL atomically:YES];
    NSDictionary *headers = @{@"X-Mashape-Key": @"aj10ReQC9XmshK4p3lJ9Z992GVPop1ZAovqjsn1NQIhK9kqhJB"};
    NSDictionary *parameters = @{@"focus[x]": @"480", @"focus[y]": @"640", @"image_request[altitude]": @"27.912109375", @"image_request[image]": imageURL, @"image_request[language]": @"en", @"image_request[latitude]": @"35.8714220766008", @"image_request[locale]": @"en_US", @"image_request[longitude]": @"14.3583203002251"};
    UNIHTTPJsonResponse* syncConnection =[[UNIRest post:^(UNISimpleRequest *request) {
                [request setUrl:@"https://camfind.p.mashape.com/image_requests"];
                [request setHeaders:headers];
                [request setParameters:parameters];
    }] asJson];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:syncConnection.rawBody
                                                                 options:kNilOptions
                                                                   error:nil];
    NSLog(@"Finished sending");
    for(NSString *key in [json allValues])
    {
        tokenValue = [json valueForKey: @"token" ];
        NSString *two = [json valueForKey: @"token" ]; // assuming the value is indeed a string
        NSLog(@"Token :%@", two);
    }
}
NSString *label = NULL;
NSString *status;
- (void) responseMethod {
    NSLog(@"Response started");
    NSString *one = @"https://camfind.p.mashape.com/image_responses" ;
    NSString *responseString = [NSString stringWithFormat:@"%@/%@", one, tokenValue];
    NSDictionary *headers = @{@"X-Mashape-Key": @"aj10ReQC9XmshK4p3lJ9Z992GVPop1ZAovqjsn1NQIhK9kqhJB", @"Accept": @"application/json"};
    bool completed = false;
    while (!completed) {
    
        UNIHTTPJsonResponse *sync = [[UNIRest get:^(UNISimpleRequest *request) {
            [request setUrl:responseString];
            [request setHeaders:headers];
        }] asJson];
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:sync.rawBody
                                                         options:kNilOptions
                                                           error:nil];
        NSString *status;
        for(NSString *key in [json allValues])
        {
            status = [json valueForKey: @"status" ]; // assuming the value is indeed a string
            NSString *name = [json valueForKey: @"name" ];
            NSLog(@"status :%@", status);
            NSLog(@"name : %@", name);
            label = name;
        }
        completed = [status isEqualToString:@"completed"];
    }
    NSLog(@"Result done");
    
}
NSString *item_name;
NSString *cal;
- (void) calculateCalories{
    NSLog(@"Starting calories");
    NSString *food = self.food.text;
    food = [food stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//    https://api.nutritionix.com/v1_1/search/hamburger?results=0:20&fields=item_name,brand_name,nf_sodium,nf_calories&appId=b7b85657&appKey=d707f312a6b40b3653276f3a2a02f0be
    NSString *url = @"https://api.nutritionix.com/v1_1/search";
    NSString *fields = @"fields=item_name,brand_name,nf_sodium,nf_calories";
    NSString *appKeyandID = @"&appId=b7b85657&appKey=d707f312a6b40b3653276f3a2a02f0be";
    NSString *responseString = [NSString stringWithFormat:@"%@/%@?results=0:1&%@&%@", url, food, fields, appKeyandID];

        
    UNIHTTPJsonResponse *sync = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:responseString];
    }] asJson];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:sync.rawBody
                                                             options:kNilOptions
                                                               error:nil];
    NSArray *json_hit = [json valueForKey:@"hits"];
    NSDictionary *json_fields = json_hit[0];
    NSDictionary *json_fields2 = [json_fields valueForKey:@"fields"];
    item_name = [json_fields2 valueForKey:@"item_name"];

//    for(id key in json_fields2)
//        NSLog(@"key=%@ value=%@", key, [json_fields2 objectForKey:key]);
    
    NSLog(@"value=%@", [json_fields2 objectForKey:@"nf_calories"]);
    long int temp = [json_fields2 objectForKey:@"nf_calories"];
    cal = [NSString stringWithFormat:@"%@", temp];
    NSLog(@"LAStly %@", cal);
    self.tier2_debug.text = item_name;
    self.food_cal.text = cal;

    NSLog(@"Finished getting calories");
}

- (IBAction) sendASBase:(NSString *)actor, (NSString *) verb, (NSString *)object {

}

- (IBAction)eat_this_button:(id)sender {

    //self.imageView.image = image;
    self.food.text = @"Sending a picture...";
    UIImage *img = self.imageView.image;

    // Tier 1
    // function call
    [self requestMethod:img];
    //self.imageView.image = image;
    self.food.text = @"Classifying an object...";
    
    // function call
    [self responseMethod];
    self.food.text = label;
//
    
    // Tier 2
    [self calculateCalories];

    
    
}

- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}
@end
