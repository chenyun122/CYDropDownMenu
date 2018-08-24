//
//  CYTitleCollectionViewCell.m
//  CYDropDownMenuDemo
//
//  Created by Yun CHEN on 2018/8/22.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//

#import "CYTitleCollectionViewCell.h"


@interface CYTitleCollectionViewCell()

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIImageView *indicatorImageView;

@end


@implementation CYTitleCollectionViewCell


- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (UIImageView *)indicatorImageView {
    if (_indicatorImageView == nil) {
        _indicatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_down"]];
        _indicatorImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_indicatorImageView];
    }
    
    return _indicatorImageView;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    
    [self.titleLabel sizeToFit];
    attributes.frame = CGRectMake(0, 0, self.titleLabel.frame.size.width + self.indicatorImageView.frame.size.width + 4.0 + 16.0, self.frame.size.height);
    
    self.titleLabel.frame = CGRectMake((attributes.frame.size.width - _titleLabel.frame.size.width - self.indicatorImageView.image.size.width - 4.0) / 2.0, 0, _titleLabel.frame.size.width, attributes.frame.size.height);
    self.indicatorImageView.frame = CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 4.0, 0, self.indicatorImageView.image.size.width, attributes.frame.size.height);

    return attributes;
}


@end
