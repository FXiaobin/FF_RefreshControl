//
//  CircleView.h
//  CLRefreshDemo
//
//  Created by 陈林 on 2017/1/13.
//  Copyright © 2017年 陈林. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CircleFromHead = 1,
    CircleFromFoot = 2,
  
} CircleFromDirectionType;

@protocol CircleViewDelegate <NSObject>

- (void) startRotate;


@end

@interface CircleView : UIView


@property (nonatomic,assign) CircleFromDirectionType cirDirection; // 标识圆圈动画飞来的方向

@property (nonatomic,assign) float radius; //圆圈半径

@property (nonatomic,assign) float lineLength; //线的长度（包括直线部分与圆环部分：经计算，设置在70±10最好）

@property (nonatomic) CGPoint circleCenter; //圆环中心位置

@property (nonatomic,assign) float pro;  //显示的进度
@property (nonatomic,assign) BOOL isAnimation; //是否在动画中

@property (nonatomic,assign )id <CircleViewDelegate>delegate;

 
- (void)showShapeWithScrollProgress:(float)progress;
@end
