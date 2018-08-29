//
//  ViewController.m
//  CYDropDownMenuDemo
//
//  Created by Yun CHEN on 2018/8/22.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//

#import "ViewController.h"
#import "CYDropDownMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CYDropDownMenu *dropDownMenu = [[CYDropDownMenu alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    dropDownMenu.sectionTitles = @[@"Category",@"Price",@"Distance"];
    dropDownMenu.sectionsItems = @[@[@"Food",@"Hotel",@"Bank",@"Cinema",@"Entertainment"],
                                   @[@"$0",@"$1-$100",@"$101-$1000",@">$1000"],
                                   @[@"0-10km",@"11-100km",@"101-1000km",@">1000km"],];
    dropDownMenu.autoCenterTitles = YES;
    [self.view addSubview:dropDownMenu];
    
    // additional customizations
    // dropDownMenu.sectionTitleColor = UIColor.redColor;
    // dropDownMenu.sectionTitleTintColor = UIColor.blueColor;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
