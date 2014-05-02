//
//  ViewController.m
//  PopoverProblemsProject
//
//  Created by smolin_in on 02/05/14.
//
//

#import "ViewController.h"
#import <WYPopoverController.h>

@interface ViewController () {
    WYPopoverController* titlePopoverController;
    WYPopoverController* searchBarPopoverController;
    WYPopoverController* transparencyPopoverController;
}

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *rightBarButtonItem;

- (IBAction)popoverTitle:(UIButton *)sender;
- (IBAction)popoverSearchBar:(UIButton *)sender;
- (IBAction)showTransparency:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [WYPopoverController setDefaultTheme:[WYPopoverTheme themeForIOS7]];

    WYPopoverBackgroundView *appearance = [WYPopoverBackgroundView appearance];
    appearance.tintColor = [UIColor colorWithRed:32 / 255.0 green:32 / 255.0 blue:32 / 255.0 alpha:0.5];
    appearance.fillTopColor = nil;
    appearance.fillBottomColor = nil;


    UIViewController* titleDummyController = [UIViewController new];
    titleDummyController.preferredContentSize = CGSizeMake(480, 320);
    UILabel* outerLabel = [UILabel new];
    outerLabel.text = @"I can't change outerStrokeColor via 'popovper.theme' property";
    outerLabel.numberOfLines = 3;
    outerLabel.textColor = [UIColor lightGrayColor];
    titleDummyController.view = outerLabel;
    titlePopoverController = [[WYPopoverController alloc] initWithContentViewController:titleDummyController];
    titlePopoverController.theme.outerStrokeColor = nil;


    UIViewController* dummyController = [UIViewController new];
    dummyController.preferredContentSize = CGSizeMake(480, 320);
    dummyController.view.backgroundColor = [UIColor colorWithRed:128 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:0.5];
    dummyController.preferredContentSize = CGSizeMake(320, 768);
    searchBarPopoverController = [[WYPopoverController alloc] initWithContentViewController:dummyController];


    UIViewController* dummyTransparencyController = [UIViewController new];
    dummyTransparencyController.preferredContentSize = CGSizeMake(480, 320);
    UILabel* transparencyLabel = [UILabel new];
    transparencyLabel.text = @"< outerStrokeColor = [UIColor clearColor] != transparent ^";
    transparencyLabel.textColor = [UIColor lightGrayColor];
    dummyTransparencyController.view = transparencyLabel;
    transparencyPopoverController = [[WYPopoverController alloc] initWithContentViewController:dummyTransparencyController];
}


- (IBAction)popoverTitle:(UIButton *)sender {
    [titlePopoverController presentPopoverFromRect:self.titleLabel.bounds
                                            inView:self.titleLabel
                          permittedArrowDirections:WYPopoverArrowDirectionAny
                                          animated:YES];
}

- (IBAction)popoverSearchBar:(UIButton *)sender {
    [self.searchBar becomeFirstResponder];
}

- (IBAction)showTransparency:(UIButton *)sender {
    [transparencyPopoverController presentPopoverFromRect:self.titleLabel.bounds
                                                   inView:self.titleLabel
                                 permittedArrowDirections:WYPopoverArrowDirectionAny
                                                 animated:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBarPopoverController presentPopoverFromRect:self.searchBar.bounds
                                                inView:self.searchBar
                              permittedArrowDirections:WYPopoverArrowDirectionAny
                                              animated:YES];

    // or you can try (same result)

//    [searchBarPopoverController presentPopoverFromBarButtonItem:self.rightBarButtonItem
//                                             permittedArrowDirections:WYPopoverArrowDirectionAny
//                                                             animated:YES];


    // "stupid" solutions

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [searchBarPopoverController presentPopoverFromRect:self.searchBar.bounds
//                                                    inView:self.searchBar
//                                  permittedArrowDirections:WYPopoverArrowDirectionAny
//                                                  animated:YES];
//    });
}

@end
