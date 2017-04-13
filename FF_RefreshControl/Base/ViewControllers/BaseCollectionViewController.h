//
//  BaseCollectionViewController.h
//  WealthCloud
//
//  Created by fanxiaobin on 2017/4/11.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import "BaseViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "UIScrollView+EmptyDataSet.h"
//#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface BaseCollectionViewController : BaseViewController<CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property  (nonatomic,strong) CHTCollectionViewWaterfallLayout *layout;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,assign) BOOL isRefreshing;

///顶部的偏移量 - 需要减去的高度 - 默认高度是：（SCREEN_HEIGHT - 64.0）
@property (nonatomic,assign) CGFloat topMargin;

///底部的偏移量 - 需要减去的高度 - 默认高度是：（SCREEN_HEIGHT - 64.0）
@property (nonatomic,assign) CGFloat offsetY;

///是否隐藏刷新控件
@property (nonatomic,assign) BOOL isHiddenRefreshControl;


@end
