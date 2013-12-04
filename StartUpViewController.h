//
//  StartUpViewController.h
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/3/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartUpViewController : UIViewController<NSURLConnectionDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSMutableData *_responseData;

@end
