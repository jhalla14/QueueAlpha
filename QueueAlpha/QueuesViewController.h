//
//  QueuesViewController.h
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/5/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollingCell.h"
#import "SpringyFlowLayout.h"
#import "User.h"

@interface QueuesViewController : UIViewController<UITableViewDataSource>
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) User *currentUser;

@end
