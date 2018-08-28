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
    dropDownMenu.sectionTitles = @[@"Menu1",@"Menu212312",@"Menu34"];
    dropDownMenu.sectionsItems = @[@[@"Menu111",@"Menu12",@"Menu13"],
                                @[@"Menu211",@"Menu22",@"Menu23"]];
    dropDownMenu.autoCenterTitles = YES;
    [self.view addSubview:dropDownMenu];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
