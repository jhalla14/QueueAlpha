//
//  StartUpViewController.h
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/3/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartUpViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) NSArray *responseData;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;

@end
