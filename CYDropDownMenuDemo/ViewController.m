//
//  ViewController.m
//  CYDropDownMenuDemo
//
//  Created by Yun CHEN on 2018/8/22.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//

#import "ViewController.h"
#import "CYDropDownMenu.h"

@interface ViewController () <CYDropDownMenuDelegate> {
    CYDropDownMenu *dropDownMenu;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat navigationBarHeight = ([UIApplication sharedApplication].statusBarFrame.size.height + (self.navigationController.navigationBar.frame.size.height ?: 0.0));
    
    dropDownMenu = [[CYDropDownMenu alloc] initWithFrame:CGRectMake(0, navigationBarHeight, self.view.frame.size.width, 45)];
    dropDownMenu.sectionTitles = @[@"Category", @"Price", @"Distance", @"Order", @"More"];
    dropDownMenu.sectionsItems = @[@[@"All",@"Food", @"Hotel", @"Bank", @"Cinema", @"Entertainment"],
                                   @[@"$0", @"$1-$100", @"$101-$1000", @">$1000"],
                                   @[@"0-10km", @"11-100km", @"101-1000km", @">1000km"],
                                   @[@"Recommended", @"Near to me", @"The highest sales", @"Hots"],
                                   @[@"24 Hours", @"Available in Holidays"]];
    dropDownMenu.autoCenterTitles = YES; //for the case there are only 1 or 2 titles, we center them.
    dropDownMenu.delegate = self;
    [self.view addSubview:dropDownMenu];
    
    // Additional customizations:
    // dropDownMenu.sectionTitleColor = UIColor.lightGrayColor;     //The color of top titles
    // dropDownMenu.sectionTitleTintColor = UIColor.redColor;       //The color of top selected titles
    // dropDownMenu.itemColor = UIColor.lightGrayColor;             //The color of menu item
    // dropDownMenu.itemTintColor = UIColor.redColor;               //The color of selected menu item
    // dropDownMenu.bottomLineHidden = YES;                         //Indicates whether display the bottom line
    // dropDownMenu.maxMenuHeight = 100;                            //Keep this to nil usually. The Menu height is automatically calculated, and limited in rootview's height. Set this property if you want to limit the height precisely.
    // dropDownMenu.rootView = self.view;                           //Keep this to nil usually. The ViewController's view will be considered as rootView if the property is not set. Set this property to limite the DropDownMenu and its actions into a particular SubView.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    dropDownMenu.frame = CGRectMake(0, 0, size.width, dropDownMenu.frame.size.height);
    
    __block typeof(dropDownMenu) blockDropDownMenu = dropDownMenu;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        CGFloat navigationBarHeight = ([UIApplication sharedApplication].statusBarFrame.size.height + (self.navigationController.navigationBar.frame.size.height ?: 0.0));
        blockDropDownMenu.frame = CGRectMake(0, navigationBarHeight, size.width, 45);
    }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}


#pragma mark - CYDropDownMenuDelegate
- (void)CYDropDownMenu:(CYDropDownMenu *)dropDownMenu didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Menu item '%@' of section '%@' is selected",dropDownMenu.sectionsItems[indexPath.section][indexPath.row], dropDownMenu.sectionTitles[indexPath.section]);
}

@end
