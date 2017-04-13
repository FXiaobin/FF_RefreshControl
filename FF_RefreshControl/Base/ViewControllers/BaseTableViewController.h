//
//  BaseTableViewController.h
//  HappySchool
//
//  Created by lovepinyao on 16/10/13.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "BaseViewController.h"
#import "UIScrollView+EmptyDataSet.h"

@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/*
    注意 ： 本类默认是UITableViewStyleGrouped风格的tableView，因为UITableViewStyleGrouped风格的会有一个默认高度（44.0）的头和尾， 所以要注意头尾视图的高度，重新设置一下
 */

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,assign) BOOL isRefreshing;

///顶部的偏移量 - 需要减去的高度 - 默认高度是：（SCREEN_HEIGHT - 64.0）
@property (nonatomic,assign) CGFloat topMargin;

///底部的偏移量 - 需要减去的高度 - 默认高度是：（SCREEN_HEIGHT - 64.0）
@property (nonatomic,assign) CGFloat offsetY;

///是否隐藏刷新控件
@property (nonatomic,assign) BOOL isHiddenRefreshControl;

-(instancetype)initWithTableViewStyle:(UITableViewStyle)style;

@end
