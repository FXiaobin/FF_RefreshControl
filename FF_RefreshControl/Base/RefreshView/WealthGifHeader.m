//
//  WealthGifHeader.m
//  WealthCloud
//
//  Created by fanxiaobin on 2017/4/12.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import "WealthGifHeader.h"

@implementation WealthGifHeader

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:@"normal"];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *pullingImages = [NSMutableArray array];
    [pullingImages addObject:[UIImage imageNamed:@"pulling"]];
    [self setImages:pullingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    [refreshingImages addObject:[UIImage imageNamed:@"normal"]];
    [refreshingImages addObject:[UIImage imageNamed:@"pulling"]];
    [refreshingImages addObject:[UIImage imageNamed:@"refreshing_01"]];
    [refreshingImages addObject:[UIImage imageNamed:@"refreshing_02"]];
    [refreshingImages addObject:[UIImage imageNamed:@"refreshing_03"]];
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    self.stateLabel.hidden = YES;
}


@end
