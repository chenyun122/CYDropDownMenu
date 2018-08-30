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
    NSMutableDictionary *selectedItemIndexes;
}

@property(nonatomic,strong) UICollectionView *titlesCollectionView;
@property(nonatomic,strong) UITableView *itemsTableView;
@property(nonatomic,strong) UIView *shadeView;
@property(nonatomic,strong) CALayer *bottomLineLayer;

@end


@implementation CYDropDownMenu

NSString *const kTitleCellId = @"CYTitleCollectionViewCell";
NSString *const kItemCellId = @"CYItemsTableViewCell";
CGFloat const kItemRowHeight = 44;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = UIColor.whiteColor;
    _itemTintColor = _sectionTitleColor = [UIColor colorWithRed:40.0/255.0 green:203.0/255.0 blue:158.0/255.0 alpha:1.0];
    _itemColor = UIColor.lightGrayColor;
    selectedItemIndexes = [NSMutableDictionary dictionary];
}

- (void)resetSelectedItemIndexes {
    for (int i=0; i<_sectionTitles.count; i++) {
        selectedItemIndexes[@(i)] = @(-1);
    }
}


#pragma mark - Properties
- (UICollectionView *)titlesCollectionView {
    if (_titlesCollectionView == nil) {
        CYTitleCollectionViewLayout *layout = [[CYTitleCollectionViewLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.estimatedItemSize = CGSizeMake(40, self.frame.size.height);
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
        _itemsTableView.separatorColor = UIColor.clearColor;
        [_itemsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kItemCellId];
    }
    
    return _itemsTableView;
}

- (UIView *)shadeView {
    if (_shadeView == nil) {
        _shadeView = [[UIView alloc] init];
        _shadeView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.4];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shadeTapped:)];
        [_shadeView addGestureRecognizer:tapGestureRecognizer];
    }
    
    return _shadeView;
}

- (CALayer *)bottomLineLayer {
    if (_bottomLineLayer == nil) {
        _bottomLineLayer = [CALayer layer];
        _bottomLineLayer.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3].CGColor;
        [self.layer addSublayer:_bottomLineLayer];
    }
    return _bottomLineLayer;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];

    self.titlesCollectionView.frame = self.bounds;
    self.bottomLineLayer.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
}

- (void)setSectionTitles:(NSArray<NSString *> *)sectionTitles{
    _sectionTitles = sectionTitles;
    [self resetSelectedItemIndexes];
    [self.titlesCollectionView reloadData];
}

- (void)setSectionsItems:(NSArray<NSArray<NSString *> *> *)sectionsItems {
    _sectionsItems = sectionsItems;
    [self resetSelectedItemIndexes];
    [self.itemsTableView reloadData];
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

- (void)setSectionTitleColor:(UIColor *)sectionTitleColor {
    _sectionTitleColor = sectionTitleColor;
    [self reloadTitleCollectionViewAndKeepSelection];
}

- (void)setSectionTitleTintColor:(UIColor *)sectionTitleTintColor {
    _sectionTitleTintColor = sectionTitleTintColor;
    [self reloadTitleCollectionViewAndKeepSelection];
}

- (void)setBottomLineHidden:(Boolean)bottomLineHidden {
    _bottomLineHidden = bottomLineHidden;
    self.bottomLineLayer.hidden = bottomLineHidden;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sectionTitles.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTitleCellId forIndexPath:indexPath];
    cell.titleColor = self.sectionTitleColor;
    cell.titleTintColor = self.sectionTitleTintColor;
    
    NSInteger selectedItemIndex = [selectedItemIndexes[@(indexPath.row)] integerValue];
    if (selectedItemIndex >= 0) {
        cell.titleLabel.text = self.sectionsItems[indexPath.row][selectedItemIndex];
    }
    else{
        cell.titleLabel.text = self.sectionTitles[indexPath.row];
    }
    
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
    
    NSInteger selectedIndex = [selectedItemIndexes[@(selectedTitleIndex)] integerValue];
    if (selectedIndex == indexPath.row) {
        cell.textLabel.textColor = self.itemTintColor;
    }
    else{
        cell.textLabel.textColor = self.itemColor;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kItemRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedItemIndexes[@(selectedTitleIndex)] = @(indexPath.row);
    
    [self.titlesCollectionView reloadData];
    __weak typeof(self) weakSelf = self;
    __block NSInteger selectedTitleIndexBlock = selectedTitleIndex;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        [weakSelf.titlesCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectedTitleIndexBlock inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    });
    
    [self shadeTapped:nil];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(CYDropDownMenu:didSelectItemAtIndexPath:)]) {
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:selectedTitleIndex];
        [self.delegate CYDropDownMenu:self didSelectItemAtIndexPath:selectedIndexPath];
    }
}


#pragma mark - Actions
- (void)displayShadeView {
    CGRect frame = [self.titlesCollectionView convertRect:self.titlesCollectionView.frame toView:self.rootView];
    frame.origin.x = 0;
    frame.origin.y += self.titlesCollectionView.frame.size.height;
    frame.size.width = self.rootView.bounds.size.width;
    frame.size.height = self.rootView.bounds.size.height - self.titlesCollectionView.frame.size.height - self.titlesCollectionView.frame.origin.y;
    self.shadeView.frame = frame;
    [_rootView addSubview:self.shadeView];
    [_rootView bringSubviewToFront:self];
}

- (void)shadeTapped:(id)sender {
    [self.shadeView removeFromSuperview];
    [self.itemsTableView removeFromSuperview];
    
    NSIndexPath *selectedIndexPath = [[self.titlesCollectionView indexPathsForSelectedItems] firstObject];
    if (selectedIndexPath) {
        CYTitleCollectionViewCell *cell = (CYTitleCollectionViewCell *)[self.titlesCollectionView cellForItemAtIndexPath:selectedIndexPath];
        [cell makeIndicatorArrowDown];
    }
}

- (void)displayItemsTableView {
    CGRect frame = [self.titlesCollectionView convertRect:self.titlesCollectionView.frame toView:self.rootView];
    frame.origin.x = 0;
    
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

- (void)reloadTitleCollectionViewAndKeepSelection {
    NSIndexPath *selectedIndexPath = [[self.titlesCollectionView indexPathsForSelectedItems] firstObject];
    [self.titlesCollectionView reloadData];
    if (selectedIndexPath) {
        [self.titlesCollectionView selectItemAtIndexPath:selectedIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
}

@end
