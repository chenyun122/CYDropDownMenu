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

    //Use line below or make dropDownMenu's frame.origin.y >= 64 to avoid the wrong insets if ViewController is with an UINavigationController
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    dropDownMenu = [[CYDropDownMenu alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 45)];
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
    // dropDownMenu.maxMenuHeight = 100;                            //The Menu height is automatically calculated, and limited in rootview's height. Set this property if you want to limit the height precisely.
    // dropDownMenu.rootView = self.view;                           //The ViewController's view will be considered as rootView if the property is not set. Set this property if limited the DropDownMenu and its actions into a particular SubView.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CYDropDownMenuDelegate
- (void)CYDropDownMenu:(CYDropDownMenu *)dropDownMenu didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Menu item '%@' of section '%@' is selected",dropDownMenu.sectionsItems[indexPath.section][indexPath.row], dropDownMenu.sectionTitles[indexPath.section]);
}

@end
