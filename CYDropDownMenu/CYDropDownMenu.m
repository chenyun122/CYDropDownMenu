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


@interface CYDropDownMenu() <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate> {
    NSInteger selectedTitleIndex;
}

@property(nonatomic,strong) UICollectionView *titlesCollectionView;
@property(nonatomic,strong) UITableView *itemsTableView;
@property(nonatomic,strong) UIView *shadeView;

@end


@implementation CYDropDownMenu

NSString *const kTitleCellId = @"CYTitleCollectionViewCell";
NSString *const kItemCellId = @"CYItemsTableViewCell";
CGFloat const kItemRowHeight = 44;

#pragma mark - Properties
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
        _itemsTableView.dataSource = self;
        _itemsTableView.delegate = self;
        [_itemsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kItemCellId];
    }
    
    return _itemsTableView;
}

- (UIView *)shadeView {
    if (_shadeView == nil) {
        _shadeView = [[UIView alloc] init];
        _shadeView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shadeTapped:)];
        [_shadeView addGestureRecognizer:tapGestureRecognizer];
    }
    
    return _shadeView;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.titlesCollectionView.frame = self.bounds;
}

- (void)setSectionTitles:(NSArray<NSString *> *)sectionTitles{
    _sectionTitles = sectionTitles;
    [self.titlesCollectionView reloadData];
}

- (void)setAutoCenterTitles:(BOOL)autoCenterTitles {
    _autoCenterTitles = autoCenterTitles;
    ((CYTitleCollectionViewLayout *)self.titlesCollectionView.collectionViewLayout).autoCenterTitles = autoCenterTitles;
}

- (UIView *)rootView {
    if (_rootView == nil) {
        _rootView= self;
        while (_rootView.superview != nil && ![_rootView.superview isKindOfClass:[UIWindow class]]) {
            _rootView = _rootView.superview;
        }
    }
    return _rootView;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sectionTitles.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTitleCellId forIndexPath:indexPath];
    cell.backgroundColor = UIColor.lightGrayColor;
    cell.title = self.sectionTitles[indexPath.row];
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    selectedTitleIndex = indexPath.row;
    [self displayShadeView];
    [self displayItemsTableView];
}


#pragma mark - UITableViewDataSource and Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (selectedTitleIndex < self.sectionsItems.count) {
        NSArray *items = self.sectionsItems[selectedTitleIndex];
        return items.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kItemCellId forIndexPath:indexPath];
    if (selectedTitleIndex < self.sectionsItems.count) {
        NSArray *items = self.sectionsItems[selectedTitleIndex];
        cell.textLabel.text = items[indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kItemRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self shadeTapped:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(CYDropDownMenu:didSelectItemAtIndexPath:)]) {
        NSIndexPath *_indexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:selectedTitleIndex];
        [self.delegate CYDropDownMenu:self didSelectItemAtIndexPath:_indexPath];
    }
}


#pragma mark - Actions
- (void)displayShadeView {
    self.shadeView.frame = self.rootView.bounds;
    [_rootView addSubview:self.shadeView];
    [_rootView bringSubviewToFront:self];
}

- (void)shadeTapped:(id)sender {
    [self.shadeView removeFromSuperview];
    [self.itemsTableView removeFromSuperview];
}

- (void)displayItemsTableView {
    CGRect frame = [self.titlesCollectionView convertRect:self.titlesCollectionView.frame toView:self.rootView];
    
    CGFloat maxHeight = self.rootView.frame.size.height - frame.origin.y - frame.size.height;
    if (self.maxMenuHeight > 0) {
        maxHeight = fminf(maxHeight, self.maxMenuHeight);
    }
    
    frame.origin.y += self.titlesCollectionView.frame.size.height;
    frame.size.height = 0;
    self.itemsTableView.frame = frame;
    
    [self.rootView addSubview:self.itemsTableView];
    [self.itemsTableView reloadData];
    
    NSInteger numberOfRows = [self tableView:self.itemsTableView numberOfRowsInSection:0];
    frame.size.height = fmin(maxHeight,numberOfRows * kItemRowHeight);

    [UIView animateWithDuration:0.4 animations:^{
        self.itemsTableView.frame = frame;
    }];
}

@end
