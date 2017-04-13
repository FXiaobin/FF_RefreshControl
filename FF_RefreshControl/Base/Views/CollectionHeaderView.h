//
//  CollectionHeaderView.h
//  WealthCloud
//
//  Created by fanxiaobin on 2017/4/11.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^headerBtnActionBlcok)(UIButton *sender);

@interface CollectionHeaderView : UICollectionReusableView

@property (nonatomic,copy) headerBtnActionBlcok clickBlock;


- (void)setLeftTitle:(NSString *)leftTitle leftImage:(NSString *)leftImage;

- (void)setRightTitle:(NSString *)rightTitle rightImage:(NSString *)rightImage clickBlock:(headerBtnActionBlcok)block;


@end
