//
//  CircleView.m
//  CLRefreshDemo
//
//  Created by 陈林 on 2017/1/13.
//  Copyright © 2017年 陈林. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor]; //先把它的背景色设置透明
        _radius = 10;
        _lineLength = 70;
        _isAnimation = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGPoint CG = CGPointMake(rect.size.width/2, rect.size.height/2);
    _circleCenter = CG;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetShouldSubpixelQuantizeFonts(ctx, YES);
    CGContextSetAllowsAntialiasing(ctx, YES);
    
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor orangeColor].CGColor);
    
    //画笔宽度
    CGContextSetLineWidth(ctx, 1);
    
    switch (self.cirDirection) {
        case CircleFromHead:
            //绘线
            CGContextMoveToPoint(ctx, _circleCenter.x, _circleCenter.y- _radius -_lineLength*(1-_pro) );
            CGContextAddLineToPoint(ctx, _circleCenter.x, _circleCenter.y-_radius  );
            
            //绘圆  (起始点-M_PI/2，终止点  M_PI/2 *3)
            CGContextAddArc(ctx, _circleCenter.x, _circleCenter.y, _radius,  -M_PI/2 ,5.0/3.0*M_PI*_pro - M_PI_2, 0);
            CGContextDrawPath(ctx, kCGPathStroke);
            break;
        case CircleFromFoot:
            //绘线
            CGContextMoveToPoint(ctx, _circleCenter.x, _circleCenter.y+ _radius +_lineLength*(1-_pro) );
            CGContextAddLineToPoint(ctx, _circleCenter.x, _circleCenter.y+_radius  );
            //绘圆  (起始点-M_PI/2，终止点  M_PI/2 *3)
            CGContextAddArc(ctx, _circleCenter.x, _circleCenter.y, _radius,  M_PI/2 ,5.0/3.0*M_PI*_pro + M_PI_2, 0);
            CGContextDrawPath(ctx, kCGPathStroke);
        default:
            break;
    }
}

- (void)showShapeWithScrollProgress:(float)progress
{
    _pro = progress;
    if (progress == 1) {
        [_delegate startRotate];
        _isAnimation = YES;
    }
   
    [self setNeedsDisplay];
}



@end
