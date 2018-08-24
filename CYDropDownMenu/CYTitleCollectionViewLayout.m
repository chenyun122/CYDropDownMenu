//
//  CYTitleCollectionViewLayout.m
//  CYDropDownMenuDemo
//
//  Created by Yun CHEN on 2018/8/24.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//

#import "CYTitleCollectionViewLayout.h"

@implementation CYTitleCollectionViewLayout

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *allAttributes = [super layoutAttributesForElementsInRect:rect];
    
    if (self.autoCenterTitles) {
        UICollectionViewLayoutAttributes *attributes = [allAttributes lastObject];
        CGRect collectionViewFrame = self.collectionView.frame;
        CGFloat leftWidth = collectionViewFrame.size.width - attributes.frame.origin.x - attributes.frame.size.width;
        if (leftWidth > 0.0 ) {
            CGFloat margin = leftWidth / (allAttributes.count + 1);

            for (int i=0; i<allAttributes.count; i++) {
                UICollectionViewLayoutAttributes *_attributes = allAttributes[i];
                CGRect frame = _attributes.frame;
                frame.origin.x += margin * (i + 1);
                _attributes.frame = frame;
            }
        }
    }
    
    return allAttributes;
}

@end
