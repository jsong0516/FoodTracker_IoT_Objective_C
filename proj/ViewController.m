//
//  ViewController.m
//  proj
//
//  Created by Byung Gon Song on 2/21/16.
//  Copyright © 2016 INFO290. All rights reserved.
//
#import "Unirest/UNIRest.h"
#import "ViewController.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <QuartzCore/QuartzCore.h>
#import "HTTPLogging.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

//#import "MyHTTPConnection.h"
//#import "HTTPConnection.h"

#import "HTTPMessage.h"
#import "HTTPDataResponse.h"
#import "DDNumber.h"
#import "HTTPLogging.h"



#import "HTTPMessage.h"
#import "HTTPResponse.h"
#import "HTTPDynamicFileResponse.h"
#import "GCDAsyncSocket.h"
#import "HTTPLogging.h"

// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = HTTP_LOG_LEVEL_VERBOSE;

#define TAG_WELCOME 10
#define TAG_CAPABILITIES 11
#define TAG_MSG 12

@import WebKit;
@import Foundation;

@interface ViewController () 

@end

@implementation MyHTTPConnection


- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path
{
    NSLog(@"supportsMethod called %@", method);
        if ([method isEqualToString:@"POST"])
        {
            return YES;
        }
        return [super supportsMethod:method atPath:path];
}

- (BOOL)expectsRequestBodyFromMethod:(NSString *)method atPath:(NSString *)path
{
    NSLog(@"expectsRequestBodyFromMethod called %@", method);
        if([method isEqualToString:@"POST"])
            return YES;
    
        return [super expectsRequestBodyFromMethod:method atPath:path];
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
    //HTTPLogTrace();
    
    NSLog(@"httpResponseForMethod called %@", method);
        if ([method isEqualToString:@"POST"] && [path isEqualToString:@"/post.html"])
        {
            NSLog(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
    
            NSString *postStr = nil;
    
            NSData *postData = [request body];
            if (postData)
            {
                postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
            }
    
            NSLog(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
    
            // Result will be of the form "answer=..."
    
            int answer = [[postStr substringFromIndex:7] intValue];
    
            NSData *response = nil;
            if(answer == 10)
            {
                response = [@"<html><body>Correct<body></html>" dataUsingEncoding:NSUTF8StringEncoding];
            }
            else
            {
                response = [@"<html><body>Sorry - Try Again<body></html>" dataUsingEncoding:NSUTF8StringEncoding];
            }
    
            return [[HTTPDataResponse alloc] initWithData:response];
        }
    //
    return [super httpResponseForMethod:method URI:path];
    //return nil;
}

- (void)prepareForBodyWithSize:(UInt64)contentLength
{
    //HTTPLogTrace();
    //NSLog(@"FINALLY4");
    // If we supported large uploads,
    // we might use this method to create/open files, allocate memory, etc.
}

bool checkin = false;
CFTimeInterval startTime;// = CACurrentMediaTime();
CFTimeInterval elapsedTime;// = CACurrentMediaTime() - startTime;
NSInteger calories = 0;
- (void) phase2:(NSString *) newStr
{
    //excerise_dict = @{@"Treadmill" : @300, @"Bicycle": @200};
    if ([newStr containsString:@"check-in"]) {
        //NSLog(@"string contains bla!");
        startTime = CACurrentMediaTime();
    } else if ([newStr containsString:@"check-out"]){
        //NSLog(@"string does not contain bla");
        elapsedTime = CACurrentMediaTime() - startTime;
        if([newStr containsString:@"Treadmill"])
        {
            NSLog(@"Treadmill called");
            calories = elapsedTime * 3 * elapsedTime;
        }
        else
        {
            NSLog(@"Bicycle called");
            calories = elapsedTime * 2 * elapsedTime;
        }
        
        NSInteger b = calories;
        NSLog(@"CALORIES UPDATED");
        
        NSLog(@"%@", temp_str);
        NSString *temp = temp_str;
        NSInteger temp2 = [temp integerValue];
        
        temp2 += b;
        NSString *aa = [@(temp2) stringValue];
        temp_str = aa;
        NSLog(@"after update %@", temp_str);
        NSString *integerAsString = [@(calories) stringValue];
        //[self sendASBASE2: 5:@"burned":@"calories":integerAsString];
        // This code should works but for not hard-coded
        NSString* jsonRequest =      [NSString stringWithFormat:@"{\"actor\": {\"objectType\": \"person\",\"displayName\": \"Byung Gon Song\"},\"verb\": \"%@\",\"object\": {\"objectType\": \"Calories\",\"displayName\": \"%@\"}}", @"burned", integerAsString];
    
    
        //NSString *jsonRequest = @"{\"actor\":\"BYUNG\",\"verb\":\"eat\"}";
        NSLog(@"Request: %@", jsonRequest);
        NSURL *url = [NSURL URLWithString:@"http://russet.ischool.berkeley.edu:8080/activities"];
    
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/stream+json" forHTTPHeaderField:@"Content-Type"];
        //[request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody: requestData];
    
        [NSURLConnection connectionWithRequest:request  delegate:self];
    
        
    
    } else
    {
        NSLog(@"We do not care ");
    }
    //NSLog(@"HAHAHAH:");
}
- (void)processBodyData:(NSData *)postDataChunk
{
    //HTTPLogTrace();

    // Remember: In order to support LARGE POST uploads, the data is read in chunks.
    // This prevents a 50 MB upload from being stored in RAM.
    // The size of the chunks are limited by the POST_CHUNKSIZE definition.
    // Therefore, this method may be called multiple times for the same POST request.

    NSLog(@"processBodyData called");
    NSString* newStr = [[NSString alloc] initWithData:postDataChunk encoding:NSUTF8StringEncoding];
    NSLog(newStr);
    [self phase2:newStr];
    BOOL result = [request appendData:postDataChunk];
    if (!result)
    {
//        HTTPLogError(@"%@[%p]: %@ - Couldn't append bytes!", THIS_FILE, self, THIS_METHOD);
        NSLog(@"ERROR in processBodydata");
    }
}

@end



@implementation ViewController


//http://stackoverflow.com/questions/6807788/how-to-get-ip-address-of-iphone-programatically
- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

- (UInt16)startServer
{
    // Start the server (and check for problems)
    // Configure our logging framework.
    // To keep things simple and fast, we're just going to log to the Xcode console.
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // Create server using our custom MyHTTPServer class
    httpServer = [[HTTPServer alloc] init];
    
    // Tell the server to broadcast its presence via Bonjour.
    // This allows browsers such as Safari to automatically discover our service.
    [httpServer setType:@"_http._tcp."];
    
    // We're going to extend the base HTTPConnection class with our MyHTTPConnection class.
    // This allows us to do all kinds of customizations.
    
    
    
    [httpServer setConnectionClass:[MyHTTPConnection class]];
    
    
    
    
    
    // Normally there's no need to run our server on any specific port.
    // Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
    // However, for easy testing you may want force a certain port so you can just hit the refresh button.
    // [httpServer setPort:12345];
    
    // Serve files from our embedded Web folder
    NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
    DDLogInfo(@"Setting document root: %@", webPath);
    
    [httpServer setDocumentRoot:webPath];
    
    NSError *error;
    if([httpServer start:&error])
    {
        UInt16 port =[httpServer listeningPort];
        NSLog(@"Started HTTP Server on port %hu", port);
        return port;
    }
    else
    {
        NSLog(@"Error starting HTTP Server: %@", error);
        return 0;
    }
    return 0;
}

- (void) update_cal{

    
}

// Initially
- (void)viewDidLoad {
    [super viewDidLoad];
    excerise_dict = @{@"Treadmill" : @3, @"Bicycle": @2};
    for(int i =0 ; i < 5; i++)
    {
        food_diary[i] = 0;
    }
    
    UInt16 port = [self startServer];
    [self createSubscriptions:port];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        temp_str = @"2400";
        while(1)
        {
            NSLog(@"Updating curr_cal %@", self.curr_cal.text);
            NSLog(@"temp_str %@", temp_str);
            [NSThread sleepForTimeInterval:5.0f];
            
            [self.curr_cal performSelectorOnMainThread: @selector(setText:)
                                    withObject: temp_str
                                 waitUntilDone: FALSE];
            
        }
    });
    
}


- (GCDAsyncUdpSocket *) createSubscriptions:(UInt16) port {
    NSLog(@"subscription creating ... ");
    //httpserver receive]
    //udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    //UInt16 port = 18501;
    //UInt16 toPort = 55056;
    NSString *currIPAdd = [self getIPAddress];
    NSString* asBaseURL = @"http://russet.ischool.berkeley.edu:8080";
    
    // (0) Put your own Host/IP/Port here - this is where ASbase will push notifications
    NSString* callbackURL = [NSString stringWithFormat:@"http://%@:%d", currIPAdd, port];
    NSLog(@"Our callbackURL is %@", callbackURL);
    
    NSString* userName = @"Testing38";
    NSString* subscriptionID = @"Testing38-Byung";
    NSString* asBaseUsersURL = [NSString stringWithFormat:@"%@/users", asBaseURL];
    
    NSURL *url = [NSURL URLWithString:@"http://russet.ischool.berkeley.edu:8080/users"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSLog(@"Registering with ASBase at %@ ...", url);
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"userID\": \"%@\",\"channels\": [ { \"type\": \"URL_Callback\", \"data\": \"%@\" } ]}", userName, callbackURL];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: requestData];
    
    id response_local = nil;
    NSError *error_local = nil;
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response_local error:&error_local];
    int code = [(NSHTTPURLResponse *)response_local statusCode];
    NSLog(@"Status code %d", code);
    
    if (code == 201 || code == 409)
    {
        // (3) And, if the creation of a subscriber was successful (i.e. status code 201) or the user already exists (i.e. status code 409), create a subscription...
        NSLog(@"User registration successful! Subscribing to events...");
        NSString *asBaseSubscriptionsURL = [NSString stringWithFormat:@"%@/%@/subscriptions", asBaseUsersURL, userName];
        NSLog(asBaseSubscriptionsURL);
        NSURL *url_BaseSubscriptions = [NSURL URLWithString:asBaseSubscriptionsURL];
        NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc] initWithURL:url_BaseSubscriptions];
        
        jsonRequest = [NSString stringWithFormat:@"{\"userID\": \"%@\",\"subscriptionID\" : \"%@\",\"ASTemplate\":  { \"actor.displayName\": { \"$in\": [ \"Byung Gon Song\" ] } } }", userName, subscriptionID];
        NSLog(jsonRequest);
        // (5) ... and HTTP POSTing that to the user's subscription URL at ASBase
        requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
        [request2 setHTTPMethod:@"POST"];
        [request2 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request2 setHTTPBody: requestData];
        
        response_local = nil;
        error_local = nil;
        receivedData = [NSURLConnection sendSynchronousRequest:request2 returningResponse:&response_local error:&error_local];
        code = [(NSHTTPURLResponse *)response_local statusCode];
        //
        if (!error_local && code == 201) {
            NSLog(@"Subscription successfully created!");
            NSLog(@"Response code: %d ", + code);
            
        } else if (!error_local && code == 409) {
            NSLog(@"Subscription already exists!");
            NSLog(@"Response code: %d ", + code);
            
        } else {
            NSLog(error_local.description);
        }
    }
    else
    {
        NSLog(@"Error %d", code);
    }
    NSLog(@"Registration Finished");

    return udpSocket;
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
        //NSLog(@"Token :%@", two);
    }
    NSString *number = [[NSString alloc] initWithFormat:@"%d", 123];
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
            //NSLog(@"status :%@", status);
            //NSLog(@"name : %@", name);
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


- (void) sendASBase{
    NSLog(@"Starting");
    
//    
//    NSDictionary *actor = @{@"url" : @"http://example.org/byung",
//                            @"objectType" : @"person",
//                            @"id" : @"tag:example.org,2016:Byung",
//                            @"displayName" : @"Byung Gon Song"};

    
    NSMutableDictionary *actor = [NSMutableDictionary dictionary];
    [actor setObject:@"person" forKey:@"objectType"];
    [actor setObject:@"Byung Gon Song" forKey:@"displayName"];
    
    
    NSLog(actor.debugDescription);
    NSString *verb = @"eat";
    
    NSDictionary *object = @{@"url" : @"http://example.org/blog/2011/02/entry",
                             @"id" : @"tag:example.org,2011:abc123/xyz"
                             };
    NSLog(object.debugDescription);
    NSDictionary *target = @{@"url" : @"http://example.org/blog",
                             @"objectType" : @"blog",
                             @"id" : @"tag:example.org,2016:Byung",
                             @"displayName" : @"testing"};
    NSLog(target.debugDescription);
    
    
    NSString *url = @"http://russet.ischool.berkeley.edu:8080/activities";
    //headers : { 'Content-Type': 'application/stream+json' }
    NSDictionary *headers = @{@"Content-Type": @"application/stream+json"};
    NSDictionary *parameters = @{@"published" : @"2011-02-10T15:04:55Z", @"verb": @"eat", @"actor": @"Byung Gon Song"};
    UNIHTTPJsonResponse* syncConnection =[[UNIRest post:^(UNISimpleRequest *request) {
        [request setUrl:url];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJson];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:syncConnection.rawBody
                                                         options:kNilOptions
                                                           error:nil];

    NSLog(@"Finished sending to ASBase");
    NSLog(@"%@", json);
//    for(NSString *key in [json allValues])
//    {
//        tokenValue = [json valueForKey: @"token" ];
//        NSString *two = [json valueForKey: @"token" ]; // assuming the value is indeed a string
//        NSLog(@"Token :%@", two);
//    }
    
}

// Resource from: http://stackoverflow.com/questions/4085978/json-post-request-on-the-iphone-using-https
- (void) sendASBASE2: (int) tier: (NSString*) verb: (NSString*) objectType : (NSString*) displayName{
    
    // Comment for ASBase for our project
    /* Format is in following format
     Tier 1
     {
     "actor": {
        "objectType": "person",
        "displayName": "Byung Gon Song"},
     "verb": "eat",
     "object": {
        "objectType": "food",
        “displayName”: “hamburger”}
     }
     Tier 2
     {
     "actor": {
        "objectType": "person",
        "displayName": "Aldrich Ong"},
     "verb": "consumed",
     "object": {
        "objectType": "calories",
        “displayName”: "700"}
     }
     Tier 3
     {
     "actor": {
        "objectType": "person",
        "displayName": "Byung Gon Song"},
     "verb": "add",
        "object": {
            "objectType": "calories",
            "displayName": 700},
        "target": {
        "objectType": "collection",
        "displayName": "Byung's Eating Diary",
        "objectTypes": ["calories"]
        }
     } = [NSString stringWithFormat:@"%@/%@", one, tokenValue];
     
     {
     "actor": {
        "objectType": "person",
        "displayName": "Byung Gon Song"},
     "verb": "publish",
     "object": {
        "objectType": "collection",
        "displayName": "[300 200 300]"
        }
     }
     {
     "actor": {
        "objectType": "person",
        "displayName": "Byung Gon Song"},
        "verb": "burned",
        "object": {
            "objectType": "calories",
            "content": 700}
     }
     
     
     
    */
    NSString *jsonRequest;
    if(tier == 1 || tier ==2)
    {
       jsonRequest= [NSString stringWithFormat:@"{\"actor\": {\"objectType\": \"person\",\"displayName\": \"%@\"},\"verb\": \"%@\",\"object\": {\"objectType\": \"%@\",\"displayName\": \"%@\"}}", @"Byung Gon Song",verb, objectType, displayName];
    }
//    else if (tier == 2)
//    {
//       jsonRequest= [NSString stringWithFormat:@"{\"actor\": {\"objectType\": \"person\",\"displayName\": \"%@\"},\"verb\": \"%@\",\"object\": {\"objectType\": \"%@\",\"displayName\": \"%@\"}}", @"Byung Gon Song",verb, objectType, displayName];
//    }
    else if(tier == 2)
    {
        jsonRequest =      [NSString stringWithFormat:@"{\"actor\": {\"objectType\": \"person\",\"displayName\": \"Byung Gon Song\"},\"verb\": \"%@\",\"object\": {\"objectType\": \"%@\",\"displayName\": \"%@\"},\"target\": {\"objectType\": \"collection\",\"displayName\": \"Byung's Eating Diary\",\"objectTypes\": [\"calories\"]}}",verb, objectType, displayName];
    }
    else if(tier == 3)
    {
        jsonRequest =      [NSString stringWithFormat:@"{\"actor\": {\"objectType\": \"person\",\"displayName\": \"Byung Gon Song\"},\"verb\": \"%@\",\"object\": {\"objectType\": \"%@\",\"displayName\": \"%@\"},\"target\": {\"objectType\": \"collection\",\"displayName\": \"Byung's Eating Diary\",\"objectTypes\": [\"calories\"]}}",verb, objectType, displayName];
    }
    else if(tier == 4) // NEW! POST
    {
        
        NSMutableString * str = [NSMutableString string];
        for (int j = 0; j<5; j++) {
            [str appendFormat:@"%i ", food_diary[j]];
        }
        
        jsonRequest =      [NSString stringWithFormat:@"{\"actor\": {\"objectType\": \"person\",\"displayName\": \"Byung Gon Song\"},\"verb\": \"%@\",\"object\": {\"objectType\": \"%@\",\"displayName\": \"%@\"}}",verb, objectType, str];
    }
    else if(tier == 5) // NEW! Burn
    {
        jsonRequest =      [NSString stringWithFormat:@"{\"actor\": {\"objectType\": \"person\",\"displayName\": \"Byung Gon Song\"},\"verb\": \"%@\",\"object\": {\"objectType\": \"%@\",\"displayName\": \"%@\"},\"target\": {\"objectType\": \"collection\",\"displayName\": \"Byung's Eating Diary\",\"objectTypes\": [\"calories\"]}}",verb, objectType, displayName];
    }
    
    //NSString *jsonRequest = @"{\"actor\":\"BYUNG\",\"verb\":\"eat\"}";
    NSLog(@"Request: %@", jsonRequest);
    
    NSURL *url = [NSURL URLWithString:@"http://russet.ischool.berkeley.edu:8080/activities"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/stream+json" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection connectionWithRequest:request  delegate:self];
}



/*
 example is from http://www.idev101.com/code/Objective-C/custom_url_schemes.html
 */
- (void) updateDiary:(NSInteger) cal
{
    food_diary[count] = cal;
    count++;
}
- (IBAction)eat_this_button:(id)sender {

//    //self.imageView.image = image;
    self.food.text = @"Sending a picture...";
    UIImage *img = self.imageView.image;

//    // Tier 1
    // function call
    [self requestMethod:img];
    self.food.text = @"Classifying an object...";
    [self responseMethod];
    self.food.text = label;
    [self sendASBASE2: 1:@"eat":@"food":label];
    
    // Tier 2
    // function call
    [self calculateCalories];
    self.tier2_debug.text = item_name;
    [self sendASBASE2: 2:@"consume":@"calories":self.food_cal.text];
    
    NSString *a = self.food_cal.text;
    NSInteger b = [a integerValue];
    total_cal += b;
    
    
    NSString *temp = self.curr_cal.text;
    NSInteger temp2 = [temp integerValue];
    NSLog(@"%@", temp);
    temp2 -= b;
    
    NSString *integerAsString = [@(temp2) stringValue];
    self.curr_cal.text =integerAsString;
    temp_str = self.curr_cal.text;
    
    [self updateDiary:b];
    
    // Tier3
    [self sendASBASE2: 3:@"add":@"calories":self.food_cal.text];
    
    // Tier 4
    [self sendASBASE2: 4:@"publish":@"calories":self.food_cal.text];
    
    // Tier 5 should be called using HTTP server
    //[self sendASBASE2: 5:@"burned":@"calories":self.food_cal.text];
    
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
