//
//  ViewController.m
//  FF_RefreshControl
//
//  Created by fanxiaobin on 2017/4/12.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "ViewController.h"
#import "TableHeaderView.h"
#import "AAAViewController.h"
#import "DemoViewController.h"


//分辨率比例
#define UI_SCALE  [UIScreen mainScreen].bounds.size.width/750.0f

#define SCALE(value)  value * UI_SCALE

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property  (nonatomic,strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self tableView];
    
    //[self collectionView];
    
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:[TableHeaderView class] forHeaderFooterViewReuseIdentifier:@"TableHeaderView"];
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SCALE(80);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    TableHeaderView *header = (TableHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TableHeaderView"];
    header.frame = CGRectMake(0, 0, self.view.bounds.size.width, SCALE(80));
    
    [header setLeftTitle:@"精品推荐" leftImage:nil];
    [header setRightTitle:@"查看更多 >" rightImage:nil clickBlock:^(UIButton *sender) {
        NSLog(@"---- title = %@",sender.currentTitle);
    }];
    
    
    return header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row > 1) {
        AAAViewController *a = [[AAAViewController alloc] init];
        [self.navigationController pushViewController:a animated:YES];
    }else{
        DemoViewController *d = [[DemoViewController alloc] init];
        [self.navigationController pushViewController:d animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
