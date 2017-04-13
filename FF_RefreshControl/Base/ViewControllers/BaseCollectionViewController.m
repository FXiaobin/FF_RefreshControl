//
//  BaseCollectionViewController.m
//  WealthCloud
//
//  Created by fanxiaobin on 2017/4/11.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import "MJRefresh/MJRefresh.h"
#import "WealthGifHeader.h"
#import "WealthGifFooter.h"
#import "WealthRefreshFooter.h"

#import "CollectionHeaderView.h"


@interface BaseCollectionViewController ()


@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navigationController.navigationBar.translucent = NO;
    
    [self collectionView];
    
}

- (void)queryData{
    //子类重写此方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    });
    
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        _layout = layout;
       
        ///默认2列 10间距  头尾高和组度为0 layout可在子类中重新设置属性来更新布局
        layout.minimumColumnSpacing = 10.0;
        layout.minimumInteritemSpacing = 10.0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource =self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView"];
        
        _collectionView.emptyDataSetSource = self;
        _collectionView.emptyDataSetDelegate = self;
        
        __weak typeof(self) weakSelf = self;
        
         //头刷新
        WealthGifHeader *header = [WealthGifHeader headerWithRefreshingBlock:^{
            weakSelf.isRefreshing = YES;
            weakSelf.currentPage = 0;
            [weakSelf queryData];
        }];
        
        _collectionView.mj_header = header;
        
        //1. 尾刷新
//        WealthGifFooter *footer = [WealthGifFooter footerWithRefreshingBlock:^{
//            weakSelf.isRefreshing = NO;
//            weakSelf.currentPage++;
//            [weakSelf queryData];
//        }];
//        _collectionView.mj_footer = footer;
        
        //2. 尾刷新
        WealthRefreshFooter *f = [WealthRefreshFooter footerWithRefreshingBlock:^{
            weakSelf.isRefreshing = NO;
            weakSelf.currentPage++;
            [weakSelf queryData];
        }];
        
        _collectionView.mj_footer = f;
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

-(void)setIsHiddenRefreshControl:(BOOL)isHiddenRefreshControl{
    if (isHiddenRefreshControl) {
        self.collectionView.mj_header = nil;
        self.collectionView.mj_footer = nil;
    }
}

-(void)setOffsetY:(CGFloat)offsetY{
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.0 - offsetY - self.topMargin);
}

- (void)setTopMargin:(CGFloat)topMargin{
    self.collectionView.frame = CGRectMake(0, topMargin, kScreenWidth, kScreenHeight - 64.0 - topMargin - self.offsetY);
}


#pragma mark --- 需要重写的方法就重写
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor orangeColor];
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}


#pragma mark --- CHTCollectionViewDelegateWaterfallLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth / 2.0 - 5, 160);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
