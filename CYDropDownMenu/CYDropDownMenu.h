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
//This funciton is called when the menu item is selected.
- (void)CYDropDownMenu:(CYDropDownMenu *)dropDownMenu didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface CYDropDownMenu : UIView

//Titles displayed in the top area.
@property(nonatomic,copy) NSArray<NSString *> *sectionTitles;

//Titles of the menu items.
@property(nonatomic,copy) NSArray<NSArray<NSString *> *> *sectionsItems;

//The Menu height is automatically calculated, and limited in rootview's height. Set this property if you want to limit the height precisely.
//Keep this to 0(automatically) usually.
@property(nonatomic,assign) CGFloat maxMenuHeight;

//For the case there are only 1 or 2 titles, we center them.
@property(nonatomic,assign) BOOL autoCenterTitles;

//The ViewController's view will be considered as the rootView if the property is not set.
//Set this property to limite the DropDownMenu and its actions into a particular SubView.
//Keep this to nil usually.
@property(nonatomic,weak) UIView *rootView;

//The color of top titles.
@property(nonatomic,strong) UIColor *sectionTitleColor;

//The color of top selected titles.
@property(nonatomic,strong) UIColor *sectionTitleTintColor;

//The color of menu item.
@property(nonatomic,strong) UIColor *itemColor;

//The color of selected menu item.
@property(nonatomic,strong) UIColor *itemTintColor;

//Indicates whether display the bottom line.
@property(nonatomic,assign) Boolean bottomLineHidden;

//A delegate to receive the IndexPath of selected item.
@property(nonatomic,weak) id<CYDropDownMenuDelegate> delegate;

@end
