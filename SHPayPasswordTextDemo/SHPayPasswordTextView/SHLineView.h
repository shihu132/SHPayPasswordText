//
//  SHLineView.h
//  SHPayPasswordTextDemo
//
//  Created by 小虎哥 on 2018/11/30.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHLineView : UIView

/** 下划线 执行动画 */
- (void)line_animation;

/** 密码字体 执行动画 */
+ (void)font_animation:(UILabel *)label;

/** 验证是否是合法数字 */
+ (BOOL)validateNumber:(NSString *)number;
//
@property (nonatomic, strong) UIView *colorView;
@end

NS_ASSUME_NONNULL_END
