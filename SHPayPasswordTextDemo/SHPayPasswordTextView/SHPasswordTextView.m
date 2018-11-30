//
//  SHPasswordTextView.m
//  SHPayPasswordTextDemo
//
//  Created by 小虎哥 on 2018/11/30.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import "SHPasswordTextView.h"
#import "SHLineView.h"

@interface SHPasswordTextView ()<UITextFieldDelegate>

@property (nonatomic, assign) NSInteger passwordCount; //密码个数
@property (nonatomic, assign) CGFloat   passwordMargin;//密码间距
@property (nonatomic, strong) NSMutableArray<UILabel    *> *labelArrayM;
@property (nonatomic, strong) NSMutableArray<SHLineView *> *lineArrayM;

@property (nonatomic, copy) NSString *tempPasswordStr;//临时保存密码
@property (nonatomic, copy) passwordStrBlock block;//回调密码
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIButton    *sh_textBtn;
@end

@implementation SHPasswordTextView

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count margin:(CGFloat)margin passwordFont:(CGFloat)passwordFont forType:(SHPasswordTextType)type block:(nonnull passwordStrBlock)block{
    if (self = [super initWithFrame:frame]) {
        
        self.frame = frame;
        self.passwordCount = count ? : 6;
        self.passwordMargin = margin ? : 20;
        self.passwordTextType = type;
        self.passwordFont = passwordFont ? : 30;
        self.passwordColor = [UIColor blackColor];//修改密码字体颜色
        self.lineColor = [UIColor redColor];//下划线颜色
        self.lineCurrentColor =[UIColor greenColor];//编辑下划线颜色
        self.block = block;
        
        [self setupTextField];
        [self createPasswordlTitle];
        [self createPasswordlLine];
    }
    return self;
}

#pragma mark - 创建子控件
- (void)setupTextField{
    
    self.backgroundColor = [UIColor whiteColor];
    self.labelArrayM = @[].mutableCopy;
    self.lineArrayM = @[].mutableCopy;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.delegate = self;
    [textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:(UIControlEventEditingChanged)];
    [self addSubview:textField];
    self.textField = textField;
  
    UIButton *sh_textBtn = [[UIButton alloc]init];
    sh_textBtn.backgroundColor = [UIColor whiteColor];
    [sh_textBtn addTarget:self action:@selector(clickTextBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:sh_textBtn];
    self.sh_textBtn = sh_textBtn;
    
}

#pragma mark - 密码显示
- (void)createPasswordlTitle{
    
    for (NSInteger i = 0; i < self.passwordCount; i++){//密码显示
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = self.passwordColor;
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:_passwordFont];
        
        switch (self.passwordTextType) {
            case SHPasswordTextTypeRectangle:
                label.layer.borderColor = [[UIColor redColor] CGColor];
                label.layer.borderWidth = 1;
                break;
            default:
                break;
        }
        [self addSubview:label];
        [self.labelArrayM addObject:label];
    }
}

#pragma mark - 下划线显示
- (void)createPasswordlLine{
    
    for (NSInteger i = 0; i < self.passwordCount; i++){
        SHLineView *line = [[SHLineView alloc]init];
        line.backgroundColor =  self.lineColor;
        if (self.passwordTextType == SHPasswordTextTypeNormal || self.passwordTextType == SHPasswordTextTypeAnimation_font ||self.passwordTextType == SHPasswordTextTypeAnimation_line ||self.passwordTextType == SHPasswordTextTypeAnimation_lineAndFont ) {
            [self addSubview:line];
        }
        [self.lineArrayM addObject:line];
    }
}

#pragma mark - 布局子视图
- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.labelArrayM.count != self.passwordCount) return;
    CGFloat temp = self.bounds.size.width - (self.passwordMargin * (self.passwordCount - 1));
    CGFloat tempW = temp / self.passwordCount;
    CGFloat tempX = 0;
    
    for (NSInteger i = 0; i < self.labelArrayM.count; i++){
        tempX = i * (tempW + self.passwordMargin);
        UILabel *label = self.labelArrayM[i];
        label.frame = CGRectMake(tempX, 0, tempW, self.bounds.size.height);
        UIView *line = self.lineArrayM[i];
        line.frame = CGRectMake(tempX, self.bounds.size.height - 1, tempW, 1);
    }
    self.textField.frame  = self.bounds;
    self.sh_textBtn.frame = self.bounds;
}

#pragma mark - 编辑改变
- (void)textFieldEditingChanged:(UITextField *)textField{
    
    if (textField.text.length > self.passwordCount) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, self.passwordCount)];
    }
    [self textFieldMobileTitle:textField];
    [self textFieldAnimation:textField];
    self.tempPasswordStr = textField.text;

    if (textField.text.length >= self.passwordCount) {
        _block(self.tempPasswordStr);//密码填满后执行
        [textField resignFirstResponder];
    }
}

#pragma mark - 编辑改变 - 密码不断改变
- (void)textFieldMobileTitle:(UITextField *)textField{
    
    for (int i = 0; i < self.passwordCount; i++){
        UILabel *labelText = [self.labelArrayM objectAtIndex:i];
        UIView  *lineView = [self.lineArrayM objectAtIndex:i];
        
        if (i < textField.text.length) {
            labelText.text = [textField.text substringWithRange:NSMakeRange(i, 1)];
            if (self.passwordSecureEntry) {
                labelText.text= @"•";
            }
            if (self.passwordTextType == SHPasswordTextTypeAnimation_line || self.passwordTextType == SHPasswordTextTypeAnimation_lineAndFont) {
                lineView.backgroundColor = self.lineCurrentColor;
            }
        } else {
            labelText.text = nil;
            lineView.backgroundColor = self.lineColor;
        }
    }
}

#pragma mark - 编辑改变 - 密码不断改变-动画
- (void)textFieldAnimation:(UITextField *)textField{

    if (self.tempPasswordStr.length < textField.text.length) {
        if (textField.text == nil || textField.text.length <= 0) {
        } else if (textField.text.length >= self.passwordCount) {
          //...输入最后一个密码执行
        } else {
            UILabel *animationLabel = self.labelArrayM[self.textField.text.length - 1];//...添加字体动画
            if (self.passwordTextType == SHPasswordTextTypeAnimation_font || self.passwordTextType == SHPasswordTextTypeAnimation_lineAndFont) {
                [SHLineView font_animation:animationLabel];
            }
        }
    }
}

#pragma mark - TextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return [SHLineView validateNumber:string];
}

#pragma mark - 成为第一个回答者
- (void)clickTextBtn{
    [self.textField becomeFirstResponder];
}

#pragma mark - 注销当前view(或它下属嵌入的text fields)的first responder 状态
- (BOOL)endEditing:(BOOL)force{
    [self.textField endEditing:force];
    return [super endEditing:force];
}

@end
