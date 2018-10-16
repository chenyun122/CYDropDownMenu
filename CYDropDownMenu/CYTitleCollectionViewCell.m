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

NSString *const kImageNameArrowDown = @"CYDropDownMenu_arrow_down";
NSString *const kImageNameArrowUp = @"CYDropDownMenu_arrow_up";

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView {
    CGRect frame = self.contentView.frame;
    frame.size.width -= 15;
    _titleLabel = [[UILabel alloc] initWithFrame:frame];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:_titleLabel];
    
    _indicatorImageView = [[UIImageView alloc] initWithImage:[self imageNamed:kImageNameArrowDown]];
    _indicatorImageView.contentMode = UIViewContentModeCenter;
    frame = _indicatorImageView.frame;
    frame.origin.y = self.contentView.frame.size.height / 2.0 - frame.size.height / 2.0;
    frame.origin.x = self.contentView.frame.size.width - frame.size.width - 8;
    _indicatorImageView.frame = frame;
    _indicatorImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self.contentView addSubview:_indicatorImageView];
}

#pragma mark - Properties
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self applyTitleColor];
}

- (void)setTitleTintColor:(UIColor *)titleTintColor {
    _titleTintColor = titleTintColor;
    [self applyTitleColor];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        _indicatorImageView.image = [self imageNamed:kImageNameArrowUp];
    }
    else{
        _indicatorImageView.image = [self imageNamed:kImageNameArrowDown];
    }
    
    [self applyTitleColor];
}

/* To fix iOS8 layout problem we are using method `sizeForItemAtIndexPath` to caculate the size instead.
#pragma mark - Overrided Functions
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    
    [self.titleLabel sizeToFit];
    attributes.frame = CGRectMake(0, 0, self.titleLabel.frame.size.width + self.indicatorImageView.frame.size.width + 4.0 + 16.0, self.frame.size.height);
    
    self.titleLabel.frame = CGRectMake((attributes.frame.size.width - _titleLabel.frame.size.width - self.indicatorImageView.image.size.width - 4.0) / 2.0, 0, _titleLabel.frame.size.width, attributes.frame.size.height);
    self.indicatorImageView.frame = CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 4.0, 0, self.indicatorImageView.image.size.width, attributes.frame.size.height);

    return attributes;
}
*/

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
    _indicatorImageView.image = [self imageNamed:kImageNameArrowDown];
}

- (UIImage *)imageNamed:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    
    //For Pods bundle
    if (image == nil) {
        NSBundle *bundle = [NSBundle bundleForClass:[CYTitleCollectionViewCell class]];
        NSURL *url = [bundle URLForResource:@"CYDropDownMenu" withExtension:@"bundle"];
        if (url != nil) {
            NSBundle *bundleWithUrl = [NSBundle bundleWithURL:url];
            image = [UIImage imageNamed:imageName inBundle:bundleWithUrl compatibleWithTraitCollection:nil];
        }
    }
    
    return image;
}

@end
