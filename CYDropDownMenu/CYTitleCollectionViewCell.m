//
//  CYTitleCollectionViewCell.m
//  CYDropDownMenuDemo
//
//  Created by Yun CHEN on 2018/8/22.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//

#import "CYTitleCollectionViewCell.h"


@interface CYTitleCollectionViewCell()


@property(nonatomic,strong) UIImageView *indicatorImageView;

@end


@implementation CYTitleCollectionViewCell

#pragma mark - Properties
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self applyTitleColor];
}

- (void)setTitleTintColor:(UIColor *)titleTintColor {
    _titleTintColor = titleTintColor;
    [self applyTitleColor];
}

- (UIImageView *)indicatorImageView {
    if (_indicatorImageView == nil) {
        _indicatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_down"]];
        _indicatorImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_indicatorImageView];
    }
    
    return _indicatorImageView;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        _indicatorImageView.image = [UIImage imageNamed:@"arrow_up"];
    }
    else{
        _indicatorImageView.image = [UIImage imageNamed:@"arrow_down"];
    }
    
    [self applyTitleColor];
}


#pragma mark - Overrided Functions
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    
    [self.titleLabel sizeToFit];
    attributes.frame = CGRectMake(0, 0, self.titleLabel.frame.size.width + self.indicatorImageView.frame.size.width + 4.0 + 16.0, self.frame.size.height);
    
    self.titleLabel.frame = CGRectMake((attributes.frame.size.width - _titleLabel.frame.size.width - self.indicatorImageView.image.size.width - 4.0) / 2.0, 0, _titleLabel.frame.size.width, attributes.frame.size.height);
    self.indicatorImageView.frame = CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 4.0, 0, self.indicatorImageView.image.size.width, attributes.frame.size.height);

    return attributes;
}


#pragma mark - Private Functions
- (void)applyTitleColor {
    if (self.selected) {
        if (_titleTintColor != nil) {
            self.titleLabel.textColor = _titleTintColor;
        }
    }
    else{
        self.titleLabel.textColor = _titleColor;
    }
}

- (void)makeIndicatorArrowDown {
    _indicatorImageView.image = [UIImage imageNamed:@"arrow_down"];
}


@end
