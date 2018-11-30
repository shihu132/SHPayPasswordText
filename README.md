# SHPayPasswordText
动画输入支付密码

###选择类型展示不同样式
typedef NS_ENUM(NSInteger, SHPasswordTextType){
    SHPasswordTextTypeNormal                = 1 <<  0, /**默认 __*/
    SHPasswordTextTypeAnimation_line        = 1 <<  1, /**line动画__*/
    SHPasswordTextTypeAnimation_font        = 1 <<  2, /**字体动画__*/
    SHPasswordTextTypeAnimation_lineAndFont = 1 <<  3, /**line和字体动画__*/
    SHPasswordTextTypeRectangle             = 1 <<  4  /**方块形☐☐*/
};


@property (nonatomic, strong) SHPasswordTextView *passwordTextView;

###///MARK:- 实例化一个密码 显示view
- (void)addPasswordTextView:(CGRect)frame {
    _passwordTextView = [[SHPasswordTextView alloc]initWithFrame:frame count:6 margin:20 passwordFont:50 forType:SHPasswordTextTypeRectangle block:^(NSString * _Nonnull passwordStr) {
        NSLog(@"shihu___passwordStr == %@",passwordStr);
    }];
    //_passwordTextView.passwordSecureEntry = YES;//安全密码
    [self.view addSubview:_passwordTextView];
}

![](https://github.com/shihu132/SHPayPasswordText/blob/master/imagesGif/aaa.gif)

![]()


![]()
