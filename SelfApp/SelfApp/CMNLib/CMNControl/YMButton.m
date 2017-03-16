
//

#import "YMButton.h"
@implementation YMButton

static char const * const buttonBlockKey = "buttonBlock";

static char const * const isSoonCliCKLimitKey = "isSoonCliCKLimit";

+(instancetype)butonInitWith:(void (^)(YMButton *))initBlock withSuperView:(UIView*)superView withMasonryMake:(MasonryMakeButton)masonryMake withButtonBlock:(ButtonBlock)buttonBlock;{
    
    YMButton* button = [YMButton butonInitWith:initBlock withSuperView:superView withButtonBlock:buttonBlock];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        masonryMake(make,button);
    }];
    return button;
    
}

+(instancetype)butonInitWith:(void(^)(YMButton* button))initBlock withSuperView:(UIView*)superView withButtonBlock:(ButtonBlock)buttonBlock{
    YMButton* button = [YMButton butonInitWith:initBlock withSuperView:superView];
    button.buttonBlock = buttonBlock;
    
    return button;
    
}

+(instancetype)butonInitWith:(void (^)(YMButton *))initBlock withSuperView:(UIView *)superView{
    YMButton* button = [YMButton buttonWithType:UIButtonTypeCustom];
    
    initBlock(button);
    
    [superView addSubview:button];
    return button;
    
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

-(ButtonBlock)buttonBlock{
    
    return objc_getAssociatedObject(self, buttonBlockKey);
}
-(BOOL)isSoonCliCKLimit{
    
    return objc_getAssociatedObject(self, isSoonCliCKLimitKey);
}

-(void)setButtonBlock:(ButtonBlock)buttonBlock{
    
    if ([self buttonBlock]== nil) {
        objc_setAssociatedObject(self, buttonBlockKey, buttonBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        // ------默认开启双击限制
        objc_setAssociatedObject(self, isSoonCliCKLimitKey, [NSNumber numberWithBool:YES], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self removeTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}
- (void)onClick:(id) sender
{
    if ([self isSoonCliCKLimit]) {
        self.userInteractionEnabled = NO;
        [self performSelector:@selector(timerDelay) withObject:self afterDelay:1.2];
    }
    if (self.buttonBlock)
    {
        self.buttonBlock(self);
    }
}
-(void)timerDelay{
    
    self.userInteractionEnabled = YES;
    
}
//-(YMButton *(^)(NSString *))buttonTitle{
//    return ^YMButton *(NSString* title){
//        [self setTitle:title forState:UIControlStateNormal];
//        return self;
//    };
//}
//
//-(YMButton *(^)(UIColor *))buttonTitleColor{
//    return ^YMButton *(UIColor* color){
//        [self setTitleColor:color forState:UIControlStateNormal];
//        return self;
//    };
//}
-(YMButton *(^)(NSString *))buttonNormalTitle{
    return ^YMButton* (NSString* title){
        [self setTitle:title forState:UIControlStateNormal];
        return self;
    };
}

-(YMButton *(^)(NSString *))buttonSelectTitle{
    return ^YMButton* (NSString* title){
        [self setTitle:title forState:UIControlStateSelected];
        return self;
    };
}

-(YMButton *(^)(UIColor *))buttonNormalTitleColor{
    return ^YMButton* (UIColor* color){
        [self setTitleColor:color forState:UIControlStateNormal];
        return self;
    };
}

-(YMButton *(^)(UIColor *))buttonSelectTitleColor{
    return ^YMButton* (UIColor* color){
        [self setTitleColor:color forState:UIControlStateSelected];
        return self;
    };
}

-(YMButton *(^)(UIColor *))buttonBackgroundColor{
    return ^YMButton *(UIColor* color){
        self.backgroundColor = color;
        return self;
    };
}
-(YMButton *(^)(CGFloat))buttonTitleFontSize{
    return ^YMButton *(CGFloat fontSize){
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}
-(YMButton *(^)(NSString *))buttonNormalImageName{
    return ^YMButton *(NSString* imageName){
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        return self;
    };
}
-(YMButton *(^)(NSString *))buttonSelectImageName{
    return ^YMButton *(NSString* imageName){
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
        return self;
    };
}
-(YMButton *(^)(UIView *))buttonSuperView{
    return ^YMButton *(UIView* view){
        [view addSubview:self];
        return self;
    };
}
-(YMButton *)with{
    return self;
}

-(YMButton *(^)(NSInteger))buttonTag{
    return ^YMButton* (NSInteger tag){
        self.tag = tag;
        return self;
    };
}

-(YMButton *(^)(UIColor *))buttonLayer_BorderColor{
    return ^YMButton *(UIColor* color){
        self.layer.borderColor = color.CGColor;
        return self;
    };
}

-(YMButton *(^)(CGFloat))buttonLayber_BorderWidth{
    return ^YMButton* (CGFloat width){
        self.layer.borderWidth = width;
        return self;
    };
}

-(YMButton *(^)(CGFloat))buttonLayer_BornerRadius{
    return ^YMButton* (CGFloat radius){
        self.layer.cornerRadius = radius;
        return self;
    };
}

-(YMButton *(^)(BOOL))buttonLayer_MaskToBounds{
    return ^YMButton* (BOOL isToBounds){
        self.layer.masksToBounds = isToBounds;
        return self;
    };
}
@end
