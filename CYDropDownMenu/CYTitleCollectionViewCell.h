//
//  CYTitleCollectionViewCell.h
//  CYDropDownMenuDemo
//
//  Created by Yun CHEN on 2018/8/22.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTitleCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIColor *titleColor;
@property(nonatomic,strong) UIColor *titleTintColor;

- (void)makeIndicatorArrowDown;

@end
