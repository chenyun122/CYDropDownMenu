//
//  CYDropDownMenu.m
//  CYDropDownMenuDemo
//
//  Created by Yun CHEN on 2018/8/22.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//

#import "CYDropDownMenu.h"
#import "CYTitleCollectionViewCell.h"
#import "CYTitleCollectionViewLayout.h"


@interface CYDropDownMenu() <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *titlesCollectionView;
@property(nonatomic,strong) UITableView *itemsTableView;

@end


@implementation CYDropDownMenu

NSString *const kTitleCellId = @"CYTitleCollectionViewCell";

- (UICollectionView *)titlesCollectionView {
    if (_titlesCollectionView == nil) {
        CYTitleCollectionViewLayout *layout = [[CYTitleCollectionViewLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.estimatedItemSize = CGSizeMake(40, 50);
        layout.autoCenterTitles = self.autoCenterTitles;
        _titlesCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _titlesCollectionView.backgroundColor = self.backgroundColor;
        _titlesCollectionView.dataSource = self;
        _titlesCollectionView.delegate = self;
        _titlesCollectionView.showsHorizontalScrollIndicator = NO;
        [_titlesCollectionView registerClass:[CYTitleCollectionViewCell class] forCellWithReuseIdentifier:kTitleCellId];
        [self addSubview:_titlesCollectionView];
    }
    
    return _titlesCollectionView;
}

- (UITableView *)itemsTableView {
    if (_itemsTableView == nil) {
        _itemsTableView = [[UITableView alloc] init];
    }
    
    return _itemsTableView;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.titlesCollectionView.frame = self.bounds;
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    [self.titlesCollectionView reloadData];
}

- (void)setAutoCenterTitles:(BOOL)autoCenterTitles {
    _autoCenterTitles = autoCenterTitles;
    ((CYTitleCollectionViewLayout *)self.titlesCollectionView.collectionViewLayout).autoCenterTitles = autoCenterTitles;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTitleCellId forIndexPath:indexPath];
    cell.backgroundColor = UIColor.lightGrayColor;
    cell.title = self.titles[indexPath.row];
    return cell;
}


@end
