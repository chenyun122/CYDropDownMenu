//
//  CYDropDownMenu.h
//  CYDropDownMenuDemo
//
//  Created by Yun CHEN on 2018/8/22.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYDropDownMenu : UIView

@property(nonatomic,copy) NSArray<NSString *> *titles;
@property(nonatomic,copy) NSArray<NSArray<NSString *> *> *groupItems;
@property(nonatomic,assign) CGFloat maxMenuHeight;
@property(nonatomic,assign) BOOL autoCenterTitles; //for the case there are only 1 or 2 titles, we center them.

@end
