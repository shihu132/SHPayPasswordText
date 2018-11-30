//
//  ViewController.m
//  SHPayPasswordTextDemo
//
//  Created by 小虎哥 on 2018/11/30.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import "ViewController.h"
#import "SHPasswordTextView.h"

@interface ViewController ()
@property (nonatomic, strong) SHPasswordTextView *passwordTextView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //标题
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 120, self.view.bounds.size.width, 15)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"有 5 种显示类型 可以查 SHPasswordTextType" ;
    [self.view addSubview:label];
    
    //实现
    CGRect frame = CGRectMake(30, CGRectGetMaxY(label.frame) + 30, self.view.bounds.size.width - 30 * 2, 50);
    [self addPasswordTextView:frame];
    [self addGestures];

}

///MARK:- 实例化一个密码 显示view
- (void)addPasswordTextView:(CGRect)frame {
    _passwordTextView = [[SHPasswordTextView alloc]initWithFrame:frame count:6 margin:20 passwordFont:50 forType:SHPasswordTextTypeRectangle block:^(NSString * _Nonnull passwordStr) {
        NSLog(@"shihu___passwordStr == %@",passwordStr);
    }];
    //_passwordTextView.passwordSecureEntry = YES;//安全密码
    [self.view addSubview:_passwordTextView];
}

///MARK:- 实例化手势
- (void)addGestures{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)];
    [self.view addGestureRecognizer:tap];
}

- (void)cancelTap{
    [self.passwordTextView endEditing:YES];
}

@end
