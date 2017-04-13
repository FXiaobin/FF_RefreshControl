//
//  Macro.h
//  FF_RefreshControl
//
//  Created by fanxiaobin on 2017/4/13.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


//分辨率比例
#define UI_SCALE  [UIScreen mainScreen].bounds.size.width/750.0f

#define kSCALE(value)  value * UI_SCALE

#endif /* Macro_h */
