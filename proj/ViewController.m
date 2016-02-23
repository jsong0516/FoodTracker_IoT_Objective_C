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

// Initially
- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString*)base64forData:(NSData*)theData {
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

// sample code found from: http://stackoverflow.com/questions/32282757/get-request-as-soon-token-received
NSString *tokenValue;
- (void) requestMethod: (UIImage *)imageToConvert{
    NSString *temp = @"saved";
    NSLog(@"%@", temp);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoryPath = [paths objectAtIndex:0];
    NSString *imagePath = [documentDirectoryPath stringByAppendingPathComponent:@"tmp_image.jpg"];
    NSURL *imageURL = [NSURL fileURLWithPath:imagePath];
    
    NSData *imageData = UIImageJPEGRepresentation(imageToConvert , 1.0);
    [imageData writeToURL:imageURL atomically:YES];
    NSString *base64image = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *headers = @{@"X-Mashape-Key": @"aj10ReQC9XmshK4p3lJ9Z992GVPop1ZAovqjsn1NQIhK9kqhJB"};
    NSDictionary *parameters = @{@"focus[x]": @"480", @"focus[y]": @"640", @"image_request[altitude]": @"27.912109375", @"image_request[image]": imageURL, @"image_request[language]": @"en", @"image_request[latitude]": @"35.8714220766008", @"image_request[locale]": @"en_US", @"image_request[longitude]": @"14.3583203002251"};
    UNIRest *post2;
    UNIUrlConnection *asyncConnection = [[UNIRest post:^(UNISimpleRequest *request) {
        [request setUrl:@"https://camfind.p.mashape.com/image_requests"];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSInteger code = response.code;
        NSDictionary *responseHeaders = response.headers;
        UNIJsonNode *body = response.body;
        NSData *rawBody = response.rawBody;
        NSString *token = response.description;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:response.rawBody
                                                             options:kNilOptions
                                                               error:nil];
        NSLog(@"Response status: %ld\n%@", (long) response.code, json);
        for(NSString *key in [json allValues])
        {
            tokenValue = [json valueForKey: @"token" ];
            NSString *two = [json valueForKey: @"token" ]; // assuming the value is indeed a string
            NSLog(@"Token :%@", two);
            NSString *one = @"https://camfind.p.mashape.com/image_responses" ;
            NSDictionary *headers = @{@"X-Mashape-Key": @"9hcyYCUJEsmsh4lNTgpgVX1xRq0Ip1uogovjsn5Mte0ONVBtes", @"Accept": @"application/json"};
            NSString *responseString = [NSString stringWithFormat:@"%@/%@", one, two];
            NSLog(@"response URL %@", responseString);
        }
    }];

}
NSString *label;
NSString *status;
- (void) responseMethod {
    // These code snippets use an open-source library.
    NSString *one = @"https://camfind.p.mashape.com/image_responses" ;
    NSString *responseString = [NSString stringWithFormat:@"%@/%@", one, tokenValue];
    NSDictionary *headers = @{@"X-Mashape-Key": @"aj10ReQC9XmshK4p3lJ9Z992GVPop1ZAovqjsn1NQIhK9kqhJB", @"Accept": @"application/json"};
    UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:responseString];
        [request setHeaders:headers];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSInteger code = response.code;
        NSDictionary *responseHeaders = response.headers;
        UNIJsonNode *body = response.body;
        NSData *rawBody = response.rawBody;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:response.rawBody
                                                             options:kNilOptions
                                                               error:nil];
        NSLog(@"Response status: %ld\n%@", (long) response.code, json);
        NSLog(@"didfinishLoading responseheader%@",responseHeaders);
    }];
}


- (IBAction)eat_this_button:(id)sender {

    //self.imageView.image = image;
    self.food.text = @"Loading...";
    self.food_cal.text = @"0";
    UIImage *img = self.imageView.image;

    // function call
    [self requestMethod:img];

    //self.imageView.image = image;
    self.food.text = @"Reading...";
    self.food_cal.text = @"0";
    // function call
    [self responseMethod];
    
    //self.imageView.image = image;
    self.food.text = label;
    self.food_cal.text = @"0";
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
