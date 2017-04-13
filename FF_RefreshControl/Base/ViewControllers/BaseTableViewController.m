//
//  BaseTableViewController.m
//  HappySchool
//
//  Created by lovepinyao on 16/10/13.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MJRefresh/MJRefresh.h"
#import "WealthGifHeader.h"
#import "WealthGifFooter.h"
#import "WealthRefreshFooter.h"


@interface BaseTableViewController ()

@property (nonatomic,assign) UITableViewStyle tableViewStyle;

@end

@implementation BaseTableViewController

-(instancetype)init{
    if (self = [super init]) {
        self.tableViewStyle = UITableViewStyleGrouped;
    }
    return self;
}

-(instancetype)initWithTableViewStyle:(UITableViewStyle)style{
    if (self = [super init]) {
        self.tableViewStyle = style;
        if ((style != UITableViewStylePlain) && (style != UITableViewStyleGrouped)) {
            self.tableViewStyle = UITableViewStylePlain;
        }
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    self.isRefreshing = YES;
    self.currentPage = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArr = [NSMutableArray array];
    
    [self createTableView];
   
    
}

- (void)queryData{
    //子类重写此方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    });
    
}

- (void)createTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:self.tableViewStyle];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    __weak typeof(self) weakSelf = self;
    //头刷新
    WealthGifHeader *header = [WealthGifHeader headerWithRefreshingBlock:^{
        weakSelf.isRefreshing = YES;
        weakSelf.currentPage = 0;
        [weakSelf queryData];
    }];
    self.tableView.mj_header = header;
    
//    //1. 尾刷新
//    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        weakSelf.isRefreshing = NO;
//        weakSelf.currentPage++;
//        [weakSelf queryData];
//    }];
//    self.tableView.mj_footer = footer;
    
    //2. 尾刷新
    //        WealthGifFooter *footer = [WealthGifFooter footerWithRefreshingBlock:^{
    //            weakSelf.isRefreshing = NO;
    //            weakSelf.currentPage++;
    //            [weakSelf queryData];
    //        }];
    //        _collectionView.mj_footer = footer;
    
    //3. 尾刷新
    WealthRefreshFooter *f = [WealthRefreshFooter footerWithRefreshingBlock:^{
        weakSelf.isRefreshing = NO;
        weakSelf.currentPage++;
        [weakSelf queryData];
    }];
    
    self.tableView.mj_footer = f;
}

-(void)setIsHiddenRefreshControl:(BOOL)isHiddenRefreshControl{
    if (isHiddenRefreshControl) {
        self.tableView.mj_header = nil;
        self.tableView.mj_footer = nil;
    }
}

-(void)setOffsetY:(CGFloat)offsetY{
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.0 - offsetY - self.topMargin);
}

- (void)setTopMargin:(CGFloat)topMargin{
    self.tableView.frame = CGRectMake(0, topMargin, kScreenWidth, kScreenHeight - 64.0 - topMargin - self.offsetY);
}

#pragma mark --- 子类重写 UITableViewDelegate , UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"baseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark ---- 无数据提示
//提示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"normal"];
    
}


//提示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"暂无数据~";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//竖直方向上的整体偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return 0.0;
}

//控件之间的上下间距
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 30.0;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return YES;
}

//是否可以滚动
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
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
