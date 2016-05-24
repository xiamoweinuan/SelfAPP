//
//  EWPButton.m
//  MemberMarket
//
//  Created by andy on 13-11-18.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "EWPButton.h"

@interface EWPButton ()

- (void)OnClick:(id) sender;
@end

@implementation EWPButton


-(void)setTitleStrNormal:(NSString *)titleStrNormal{
  [self setTitle:titleStrNormal forState:UIControlStateNormal];
}

-(void)setColorNormalTitleColor:(UIColor *)colorNormalTitleColor{
    [self setTitleColor:colorNormalTitleColor forState:UIControlStateNormal];
}
-(void)setColorHighlightedTitleColor:(UIColor *)colorHighlightedTitleColor{
    [self setTitleColor:colorHighlightedTitleColor forState:UIControlStateHighlighted];
}

-(void)setIamgeNormalBackgroundImage:(UIImage *)iamgeNormalBackgroundImage{
        [self setBackgroundImage:iamgeNormalBackgroundImage forState:UIControlStateNormal];
}
-(void)setIamgeHighlightedBackgroundImage:(UIImage *)iamgeHighlightedBackgroundImage{
      [self setBackgroundImage:iamgeHighlightedBackgroundImage forState:UIControlStateHighlighted];
}



-(void)colorNormalTitleColor:(UIColor*)colorNor withcolorHighlightedTitleColor:(UIColor*)colorHigh{
    [self setColorNormalTitleColor:colorNor];
    [self setColorHighlightedTitleColor:colorHigh];
}
-(void)iamgeNormalBackgroundImage:(UIImage*)imageNor withIamgeHighlightedBackgroundImage:(UIImage*)imageHigh{
    
    [self setIamgeNormalBackgroundImage:imageNor];
    [self setIamgeHighlightedBackgroundImage:imageHigh];
}

+(instancetype)buttonWithButtonWithFrame:(CGRect)frame withButtonBlock:(ButtonBlock)buttonBlocck{
    EWPButton * button = [super buttonWithType:UIButtonTypeCustom];
    if (button) {
        button.frame = frame;
        [button setButtonBlock:buttonBlocck];
       
        
    }
    
    
    return button;
}
+(instancetype)buttonWithButtonWithFrame:(CGRect)frame withTitle:(NSString*)title withFontSize:(CGFloat)size withTitleClor:(UIColor*)color withButtonBlock:(ButtonBlock)buttonBlocck{
    EWPButton * button = [super buttonWithType:UIButtonTypeCustom];
    if (button) {
        button.frame = frame;
        [button setButtonBlock:buttonBlocck];
        [button setTitleStrNormal:title];
        [button.titleLabel setFont:[UIFont systemFontOfSize:size]];
        [button setColorNormalTitleColor:color];
        
    }
    
    
    return button;
}

- (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)setButtonBlock:(ButtonBlock)buttonBlock
{
    if (buttonBlock)
    {
        _buttonBlock = nil;
        _buttonBlock = [buttonBlock copy];
         // ------默认开启双击限制
        self.isSoonCliCKLimit = YES;
        [self removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)setIsSoonCliCKLimit:(BOOL)isSoonCliCKLimit{
    _isSoonCliCKLimit =isSoonCliCKLimit;
}
/*按钮响应函数*/
- (void)OnClick:(id) sender
{
    if (_isSoonCliCKLimit) {
        self.userInteractionEnabled = NO;
        [self performSelector:@selector(timerDelay) withObject:self afterDelay:1.2];
    }
    
    if (_buttonBlock)
    {
        _buttonBlock(self);
    }
}
-(void)timerDelay{
    self.userInteractionEnabled = YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (self.autotoggleEnabled) {
        self.select = !self.select;
        if (self.iamgeSelect) {
            [self setIamgeHighlightedBackgroundImage:self.select? self.iamgeSelect:self.iamgeNormalBackgroundImage];
        }
        if (self.colorTitleSelect) {
            [self setColorNormalTitleColor:self.select? self.colorTitleSelect :self.colorNormalTitleColor];

        }
        if (self.titleSelect) {
            [self setTitleStrNormal:self.select? self.titleSelect :self.titleStrNormal];
        }
        
    }
}
@end
