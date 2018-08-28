//
//  CYDropDownMenu.h
//  CYDropDownMenuDemo
//
//  Created by Yun CHEN on 2018/8/22.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYDropDownMenu;

@protocol CYDropDownMenuDelegate <NSObject>
@optional
- (void)CYDropDownMenu:(CYDropDownMenu *)dropDownMenu didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface CYDropDownMenu : UIView

@property(nonatomic,copy) NSArray<NSString *> *sectionTitles;
@property(nonatomic,copy) NSArray<NSArray<NSString *> *> *sectionsItems;
@property(nonatomic,assign) CGFloat maxMenuHeight;
@property(nonatomic,assign) BOOL autoCenterTitles; //for the case there are only 1 or 2 titles, we center them.
@property(nonatomic,weak) UIView *rootView;

@property(nonatomic,weak) id<CYDropDownMenuDelegate> delegate;

@end
