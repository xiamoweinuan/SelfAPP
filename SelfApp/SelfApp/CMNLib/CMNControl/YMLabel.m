//
//  YMLabel.m
//  YunMaiQ
//
//  Created by 高爽 on 17/3/1.
//  Copyright © 2017年 XR. All rights reserved.
//

#import "YMLabel.h"

@implementation YMLabel
+(instancetype)labelInitWith:(void (^)(YMLabel *label))initBlock{
    
    YMLabel* label = [[YMLabel alloc]init];
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    label.textAlignmentvertical = VerticalAlignmentMiddle;
    initBlock(label);
    
    if (label.superview == nil) {
        //        NSAssert(0, @"未设置superview");
    }
    return label;
}
+(instancetype)labelInitWithSuperView:(UIView*)superView WithBlock:(void (^)(YMLabel *label))initBlock{
    
    YMLabel* labelInit =[self labelInitWith:initBlock];
    labelInit.labelSuperView(superView);
    return labelInit;
}


+(instancetype)labelInitWithSuperView:(UIView*)superView WithBlock:(void (^)(YMLabel *label))initBlock withLabelWithMas_makeConstraints:(MasonryMake)masonryMake {
    
    YMLabel* labelInit =[self labelInitWith:initBlock];
    labelInit.labelSuperView(superView);
    
    [labelInit mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize size;
        if (labelInit.sizeFree.height!= 0||labelInit.sizeFree.width!= 0) {
            size = labelInit.sizeFree;
        }else{
            size = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
        }
        labelInit.sizeFree = [labelInit sizeConfirmToSize:size];
        //------小数点精确引起的误差
        labelInit.sizeFree = CGSizeMake(labelInit.sizeFree.width+0.5, labelInit.sizeFree.height+0.5);
        masonryMake(make,labelInit);
    }];
    
    
    return labelInit;
}

-(void)labelWithMas_makeConstraints:(MasonryMake)masonryMake{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize size;
        if (self.sizeFree.height!= 0||self.sizeFree.width!= 0) {
            size = self.sizeFree;
        }else{
            size = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
        }
        self.sizeFree = [self sizeConfirmToSize:size];
        //------小数点精确引起的误差
        self.sizeFree = CGSizeMake(self.sizeFree.width+0.5, self.sizeFree.height+0.5);
        masonryMake(make,self);
    }];
    
}
-(void)free{
    
}
-(void)setLabelTextUpdate:(NSString *)labelTextUpdate{
    
    self.text = labelTextUpdate;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        CGSize size;
        //------更新位置的时候sizeFree是有的，这里默认高度为1行的时候重新计算sizeFree
        if ((self.sizeFree.height!= 0||self.sizeFree.width!= 0)&& self.numberOfLines!=1) {
            size = self.sizeFree;
        }else{
            size = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
        }
        self.sizeFree = [self sizeConfirmToSize:size];
        //------小数点精确引起的误差
        self.sizeFree = CGSizeMake(self.sizeFree.width+0.5, self.sizeFree.height+0.5);
        make.size.mas_equalTo(self.sizeFree);
        
    }];
    
}

-(YMLabel *)with{
    return self;
}


-(YMLabel *(^)(UIView *))labelSuperView{
    return ^YMLabel *(UIView* view){
        [view addSubview:self];
        return self;
    };
}


-(YMLabel *(^)(NSString *))labelText{
    return ^YMLabel *(NSString* text){
        self.text  = text;
        [self sizeToFit];
        return self;
    };
}

-(YMLabel *(^)(CGFloat))labelFont{
    return ^YMLabel *(CGFloat fontSize){
        self.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}
-(YMLabel *(^)(CGFloat))labelBoldFont{
    return ^YMLabel *(CGFloat fontSize){
        self.font = [UIFont boldSystemFontOfSize:fontSize];
        return self;
    };
}

-(YMLabel *(^)(UIColor *))labelTextColor{
    return ^YMLabel *(UIColor* color){
        self.textColor = color;
        return self;
    };
}

-(YMLabel *(^)(UIColor *))labelBackgroundColor{
    return ^ YMLabel *(UIColor* color){
        self.backgroundColor = color;
        return self;
    };
}

- (YMLabel *(^)(NSTextAlignment))labelTextAlignment{
    return ^YMLabel *(NSInteger textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}
-(YMLabel *(^)(NSInteger))labelNumberLines{
    return ^YMLabel *(NSInteger numberLines){
        self.numberOfLines = numberLines;
        return self;
    };
}

-(YMLabel *(^)(NSString *, UIColor *, CGFloat))labelCommon{
    return^ YMLabel*(NSString* text,UIColor* color,CGFloat fontSize){
        self.text = text;
        self.textColor = color;
        self.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}
-(YMLabel *(^)(CGSize))labelSizeFree{
    return^ YMLabel*(CGSize size){
        self.sizeFree =size;
        return self;
    };
}
-(YMLabel *(^)(TextAlignmentVertical))labelTextAlignmentVertical{
    return^ YMLabel*(TextAlignmentVertical verticalAlignment ){
        self.textAlignmentvertical =verticalAlignment;
        return self;
    };
}

-(void)setTextAlignmentvertical:(TextAlignmentVertical)textAlignmentvertical{
    _textAlignmentvertical = textAlignmentvertical;
    [self setNeedsDisplay];
}

#pragma mark - **************** 垂直方向对齐
-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (_textAlignmentvertical) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}



// 设置某段字的颜色
- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    NSMutableAttributedString* string = [[NSMutableAttributedString alloc]initWithString:self.text];
    
    
    [string addAttribute:NSForegroundColorAttributeName
                   value:color
                   range:NSMakeRange(location, length)];
    [self setAttributedText:string];
}

// 设置某段字的字体
- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    NSMutableAttributedString* string = [[NSMutableAttributedString alloc]initWithString:self.text];
    [string addAttribute:(NSString *)kCTFontAttributeName
                   value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)font.fontName,
                                                                    font.pointSize*2,
                                                                    NULL))
                   range:NSMakeRange(location, length)];
}

// 设置某段字的风格
- (void)setStyle:(CTUnderlineStyle)style fromIndex:(NSInteger)location length:(NSInteger)length{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    
    NSMutableAttributedString* string = [[NSMutableAttributedString alloc]initWithString:self.text];
    [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                   value:(id)[NSNumber numberWithInt:style]
                   range:NSMakeRange(location, length)];
}


-(CGSize)sizeConfirmToSize:(CGSize)size{
    
    return    ([self.text boundingRectWithSize:CGSizeMake(size.width, size.height)  options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:(self.font.pointSize)]} context:nil].size);
    
    
}

@end

