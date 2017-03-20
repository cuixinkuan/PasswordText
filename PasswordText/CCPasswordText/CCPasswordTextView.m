//
//  CCPasswordTextView.m
//  PasswordText
//
//  Created by admin on 17/3/17.
//  Copyright © 2017年 CuiXinKuan. All rights reserved.
//

#import "CCPasswordTextView.h"

@interface CCPasswordTextView ()

@property (nonatomic,weak)UITextField * textField;
@property (nonatomic,strong)NSMutableArray<UITextField *> * dataArr;

@end

@implementation CCPasswordTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupPasswordTextView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = (self.bounds.size.width - (self.elementCount - 1) * self.elementMargin) / self.elementCount;
    CGFloat h = self.bounds.size.height;
    
    for (NSUInteger i = 0 ; i < self.dataArr.count; i ++ ) {
        UITextField * pdTextField = [self.dataArr objectAtIndex:i];
        x = (w + self.elementMargin) * i;
        pdTextField.frame = CGRectMake(x, y, w, h);
    }
}

// 自定义密码输入框
- (void)setupPasswordTextView {
    UITextField * textField = [[UITextField alloc] initWithFrame:self.bounds];
    textField.hidden = YES;
    textField.keyboardType = UIKeyboardTypeDefault;
    [textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:textField];
    self.textField = textField;
    
    self.backgroundColor = [UIColor whiteColor];
    self.autoHiddenKeyboard = YES;
    self.elementBorderColor = [UIColor lightGrayColor];
    self.elementBorderWidth  = 1;
}

- (void)setElementCount:(NSInteger)elementCount {
    _elementCount = elementCount;
    if (elementCount <= 0 ) {
        return;
    }
    
    if (self.dataArr.count > 0) {
        [self.dataArr enumerateObjectsUsingBlock:^(UITextField * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [NSObject cancelPreviousPerformRequestsWithTarget:obj selector:@selector(removeFromSuperview) object:nil];
        }];
        
        [self.dataArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.dataArr removeAllObjects];
    }
    
    // dataArr
    for (int i = 0; i < self.elementCount; i ++ ) {
        UITextField * pwdTextField = [[UITextField alloc] init];
        pwdTextField.enabled = NO;
        pwdTextField.userInteractionEnabled = NO;
        pwdTextField.textAlignment = NSTextAlignmentCenter;
        pwdTextField.secureTextEntry = YES;
        [self insertSubview:pwdTextField belowSubview:self.textField];
        [self.dataArr addObject:pwdTextField];
    }
    
}

- (void)setElementMargin:(CGFloat)elementMargin {
    _elementMargin = elementMargin;
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showKeyboard];
}

#pragma mark - public methods -
- (void)setValidationBoardType:(ValidationBoardType)validationBoardType {
    self.textField.keyboardType = UIKeyboardTypeDefault;
    if (validationBoardType == VALIDATION_BOARDTYPE_DEFAULT) {
        self.textField.keyboardType = UIKeyboardTypeDefault;
    }else if (validationBoardType == VALIDATION_BOARDTYPE_NUMBER) {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
}

- (void)clearPassword {
    self.textField.text = nil;
    [self textChange:self.textField];
}

- (void)showKeyboard {
    [self.textField becomeFirstResponder];
}

- (void)hideKeyboard {
    [self.textField resignFirstResponder];
}

#pragma mark - private methods -
// 改变输入框内容
- (void)textChange:(UITextField *)textField {
    NSString * password = textField.text;
    if (password.length > self.elementCount) {
        textField.text = [password substringToIndex:self.elementCount];
        return;
    }
    
    for (int i = 0 ; i < self.dataArr.count; i ++ ) {
        UITextField * pdTextField = [self.dataArr objectAtIndex:i];
        if (password.length > i) {
            NSString * pwd = [password substringWithRange:NSMakeRange(i, 1)];
            pdTextField.text = pwd;
        }else {
            pdTextField.text = nil;
        }
    }
    
    if (password.length == self.dataArr.count) { // 隐藏键盘
        if (self.autoHiddenKeyboard) {
            [self hideKeyboard];
        }
    }
    
    !self.passwordDidChangeBlock ? : self.passwordDidChangeBlock(textField.text); // 密码回调
}

#pragma mark - lazy -
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.backgroundColor set];
    CGContextFillRect(context, rect);
    
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, self.elementBorderWidth);
    CGContextSetStrokeColorWithColor(context, self.elementBorderColor.CGColor);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextBeginPath(context);
    
    if (self.elementMargin != 0) {
        for (UITextField * textField in self.dataArr) {
            CGRect rect = CGRectInset(textField.frame, self.elementBorderWidth, self.elementBorderWidth);
            CGFloat left = rect.origin.x;
            CGFloat right = rect.origin.x + rect.size.width;
            CGFloat top = rect.origin.y;
            CGFloat bottom = rect.origin.y + rect.size.height;
            
            CGContextMoveToPoint(context, left, top);
            CGContextAddLineToPoint(context, right, top);
            CGContextAddLineToPoint(context, right, bottom);
            CGContextAddLineToPoint(context, left, bottom);
            CGContextClosePath(context);
        }
    }else {
        CGPoint leftTopPoint, rightTopPoint, leftBottomPoint, rightBottomPoint;
        for (NSUInteger i = 0; i < self.dataArr.count; i++) {
            UITextField *textField = [self.dataArr objectAtIndex:i];
            CGRect rect = CGRectInset(textField.frame, self.elementBorderWidth, self.elementBorderWidth);
            CGFloat left = rect.origin.x;
            CGFloat right = rect.origin.x + rect.size.width;
            CGFloat top = rect.origin.y;
            CGFloat bottom = rect.origin.y + rect.size.height;
            
            CGContextMoveToPoint(context, left, top);
            CGContextAddLineToPoint(context, left, bottom);
            CGContextClosePath(context);
            if (self.dataArr.count - 1 == i) {
                CGContextMoveToPoint(context, right, top);
                CGContextAddLineToPoint(context, right, bottom);
                CGContextClosePath(context);
                rightTopPoint = CGPointMake(right, top);
                rightBottomPoint = CGPointMake(right, bottom);
            }else if (0 == i) {
                leftTopPoint = CGPointMake(left, top);
                leftBottomPoint = CGPointMake(left, bottom);
            }
        }
        
        CGContextMoveToPoint(context, leftTopPoint.x, leftTopPoint.y);
        CGContextAddLineToPoint(context, rightTopPoint.x, rightTopPoint.y);
        CGContextClosePath(context);
        
        CGContextMoveToPoint(context, leftBottomPoint.x, leftBottomPoint.y);
        CGContextAddLineToPoint(context, rightBottomPoint.x, rightBottomPoint.y);
        CGContextClosePath(context);
    }
    
    CGContextStrokePath(context);
}

@end
