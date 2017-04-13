//
//  WealthRefreshFooter.m
//  WealthCloud
//
//  Created by fanxiaobin on 2017/4/12.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import "WealthRefreshFooter.h"
#import "CircleView.h"

@interface WealthRefreshFooter ()<CircleViewDelegate>


@property (nonatomic,strong) CircleView *circleView;

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation WealthRefreshFooter

-(void)startRotate{
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.8;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    
    if (self.state == MJRefreshStateRefreshing) {
        [_circleView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }
    
}

-(void)endRefreshing{
    [super endRefreshing];
    
    NSArray *animationKeys = _circleView.layer.animationKeys;
    if (animationKeys.count > 0 && [animationKeys.firstObject isEqualToString:@"rotationAnimation"]) {
        [_circleView.layer removeAnimationForKey:@"rotationAnimation"];
    }
    
    [_circleView  showShapeWithScrollProgress:0.0];
}

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    CircleView *footerCircle = [[CircleView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 160)/2.0, (self.mj_h - 30)/2.0, 30, 30)];
    footerCircle.cirDirection = CircleFromFoot;
    footerCircle.delegate = self;
    self.circleView = footerCircle;
    
    [self addSubview:footerCircle];
    
    // 添加label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.circleView.frame) + 20.0, CGRectGetMinY(self.circleView.frame), 110, CGRectGetHeight(self.circleView.frame))];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    self.titleLabel = label;
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    _circleView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 160)/2.0, (self.mj_h - 30)/2.0, 30, 30);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.circleView.frame) + 20.0, CGRectGetMinY(self.circleView.frame), 110, CGRectGetHeight(self.circleView.frame));
  
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
 
    float progress = self.pullingPercent;
    //NSLog(@"--- progerss = %.1f",progress);
    progress = progress > 1 ? 1 : progress;
    [_circleView  showShapeWithScrollProgress:progress];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];

}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    _circleView.isAnimation = NO;
    switch (state) {
            case MJRefreshStateIdle:
            self.titleLabel.text = @"上拉即可加载";
            break;
            
            case MJRefreshStatePulling:
            self.titleLabel.text = @"松开即可加载";
            break;
            
            case MJRefreshStateRefreshing:
            self.titleLabel.text = @"加载数据中...";
            
            break;
            case MJRefreshStateNoMoreData:
            self.titleLabel.text = @"没有更多数据啦~";
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
//- (void)setPullingPercent:(CGFloat)pullingPercent
//{
//    [super setPullingPercent:pullingPercent];
//    
//    // 1.0 0.5 0.0
//    // 0.5 0.0 0.5
//    CGFloat red = 1.0 - pullingPercent * 0.5;
//    CGFloat green = 0.5 - 0.5 * pullingPercent;
//    CGFloat blue = 0.5 * pullingPercent;
//    self.titleLabel.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//}


@end
