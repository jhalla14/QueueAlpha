//
//  FirstViewController.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 11/28/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "FirstViewController.h"
#import "QueueModel.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *clicksLabel;
@property (nonatomic) int clickCount;

@property (nonatomic, strong) QueueModel *model;

//@property (weak, nonatomic) IBOutlet UITextView *body;
//@property (weak, nonatomic) IBOutlet UILabel *headline;
//@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation FirstViewController
//- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender
//{
//    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
//                                  value:sender.backgroundColor
//                                  range:self.body.selectedRange];
//}
//- (IBAction)outlineBodySelection:(UIButton *)sender
//{
//    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName:@-3, NSStrokeColorAttributeName:[UIColor blackColor]} range:self.body.selectedRange];
//}
//- (IBAction)unoutlineBodySelection:(UIButton *)sender
//{
//    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
//                                     range:self.body.selectedRange];
//}


- (QueueModel *) model
{
    if (!_model) _model = [[QueueModel alloc] initWithTableCount:0];
        return _model;

}

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
//    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
//    
//    [title setAttributes:@{NSStrokeWidthAttributeName: @3, NSStrokeColorAttributeName:self.outlineButton.tintColor} range:NSMakeRange(0, [title length])];
//    
//    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
    //initilization and outlet setting
    //only called once in lifetime of controller
    //called before going on screen
}

- (void) viewWillLayoutSubviews
{
    //called right before ios layouts views
    //put geometry stuff here
}

- (void) viewDidLayoutSubviews
{
    //called after viewWillLayoutSubviews
}


- (void) viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:animated];
//    [self usePreferredFonts];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontsChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
//    
    //guarented that view will appear
}

//- (void) preferredFontsChanged: (NSNotification *) notification
//{
////    [self usePreferredFonts];
//
//}

//- (void) usePreferredFonts
//{
//    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
//    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
//}

- (void) viewDidAppear:(BOOL)animated
{
    //called just before view goes on screen
    //called multiple times (everytime view is on screen)
    //change of views based on data (things that changed before being visible)
}

- (void) viewWillDisappear:(BOOL)animated
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
//    //remember what's going on and cleanup code
    //rememberScroolPosition
}

- (void) viewDidDisappear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
//    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //try to free up memory in the heap
    //set strong pointers to nil
}

@end
