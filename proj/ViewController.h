//
//  ViewController.h
//  proj
//
//  Created by Byung Gon Song on 2/21/16.
//  Copyright © 2016 INFO290. All rights reserved.
//

#import <UIKit/UIKit.h>

@import CocoaAsyncSocket;
@import CocoaLumberjack;

@class iPhoneHTTPServerViewController;
@class HTTPServer;


NSString *temp_str;

#import "HTTPConnection.h"
@interface MyHTTPConnection : HTTPConnection




@end

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    long tag;
    long count;
    GCDAsyncUdpSocket *udpSocket;
    HTTPServer *httpServer;
    NSDictionary *excerise_dict;
    NSInteger food_diary[5];
    NSInteger total_cal;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *curr_cal;
@property (weak, nonatomic) IBOutlet UILabel *tier2_debug;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
@property (weak, nonatomic) IBOutlet UILabel *food;
@property (weak, nonatomic) IBOutlet UILabel *food_cal;
- (IBAction)eat_this_button:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;



@end

