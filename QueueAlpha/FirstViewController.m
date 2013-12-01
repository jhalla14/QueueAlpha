//
//  FirstViewController.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 11/28/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *clicksLabel;
@property (nonatomic) int clickCount;

@end

@implementation FirstViewController

- (void) setClickCount:(int)clickCount
{
    _clickCount = clickCount;
    self.clicksLabel.text = [NSString stringWithFormat:@"Clicks: %d", self.clickCount];
    
}

- (IBAction)touchTestButton:(UIButton *)sender
{
    
    if ([[sender.currentTitle description]  isEqual: @"Test"] ){
        [sender setTitle:@"Yup" forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"Test" forState:UIControlStateNormal];
 
    }
    self.clickCount++;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
