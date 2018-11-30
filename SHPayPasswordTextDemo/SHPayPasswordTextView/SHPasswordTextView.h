//
//  SHPasswordTextView.h
//  SHPayPasswordTextDemo
//
//  Created by 小虎哥 on 2018/11/30.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^passwordStrBlock)(NSString *passwordStr);

typedef NS_ENUM(NSInteger, SHPasswordTextType){
    SHPasswordTextTypeNormal                = 1 <<  0, /**默认 __*/
    SHPasswordTextTypeAnimation_line        = 1 <<  1, /**line动画__*/
    SHPasswordTextTypeAnimation_font        = 1 <<  2, /**字体动画__*/
    SHPasswordTextTypeAnimation_lineAndFont = 1 <<  3, /**line和字体动画__*/
    SHPasswordTextTypeRectangle             = 1 <<  4  /**方块形☐☐*/
};

@interface SHPasswordTextView : UIView

/**
 设置密码字体大小
 默认为字体为 30.0f;
 */
@property(nonatomic,assign) CGFloat passwordFont;

/**
 设置密码显示颜色
  -默认颜色为黑色
 */
@property (nonatomic, strong) UIColor *passwordColor;

/**
 设置密码显示明文/密文
 - default is NO
 */
@property(nonatomic,getter=isPasswordSecureEntry) BOOL passwordSecureEntry;

/**
 设置 line显示颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 设置 line显示 当前颜色
 -默认颜色为
 */
@property (nonatomic, strong) UIColor *lineCurrentColor;

/**
 设置密码显示类型
 */
@property(nonatomic,assign) SHPasswordTextType passwordTextType;

/**
 初始化 设置交易密码
 @param count 密码个数
 @param margin 密码之间间距
 @param passwordFont 密码字体大小
 @param type 密码显示样式
 @param block 密码字符串返回
 */
- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count margin:(CGFloat)margin passwordFont:(CGFloat)passwordFont forType:(SHPasswordTextType)type block:(nonnull passwordStrBlock)block;

@end

NS_ASSUME_NONNULL_END
