//
//  YMLabel.h
//  YunMaiQ
//
//  Created by 高爽 on 17/3/1.
//  Copyright © 2017年 XR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>
typedef enum
{
    VerticalAlignmentTop = 0, // 距上对齐
    VerticalAlignmentMiddle,  //居中对齐
    VerticalAlignmentBottom,  //距下对齐
} TextAlignmentVertical;

@interface YMLabel : UILabel

typedef void(^MasonryMake)(MASConstraintMaker *make, YMLabel* label);

@property (nonatomic, copy)YMLabel* (^labelText)(NSString* text);

@property (nonatomic, copy)YMLabel* (^labelSuperView)(UIView* view);

@property (nonatomic, strong)YMLabel* with;

@property (nonatomic, copy)YMLabel* (^labelTextColor)(UIColor* color);

@property (nonatomic, copy)YMLabel* (^labelBackgroundColor)(UIColor* color);

@property (nonatomic, copy)YMLabel* (^labelFont)(CGFloat fontSize);

@property (nonatomic, copy)YMLabel* (^labelBoldFont)(CGFloat fontSize);

/** 对齐方式，水平方向*/
@property (nonatomic, copy)YMLabel* (^labelTextAlignment)(NSTextAlignment textAlignment);

/** 对齐方式，垂直方向*/
@property (nonatomic, copy)YMLabel* (^labelTextAlignmentVertical)(TextAlignmentVertical);

@property (nonatomic, copy)YMLabel* (^labelNumberLines)(NSInteger NumberLine);

/** (NSString* text,UIColor* color,CGFloat fontSize)*/
@property (nonatomic, copy)YMLabel* (^labelCommon)(NSString* text,UIColor* color,CGFloat fontSize);

/** 自适应的size,需要限制的话需要设置在Masonry之前设置labelSizeFree或者sizeFree*/
@property (nonatomic, copy)YMLabel* (^labelSizeFree)(CGSize size);

@property (nonatomic,assign)CGSize sizeFree;

/** 对齐方式，垂直方向*/
@property (nonatomic, assign)TextAlignmentVertical textAlignmentvertical;

/** 如果用sizefree设置的size更新的时候用labelTextUpdate方法*/
@property (nonatomic, strong)NSString* labelTextUpdate;

/** 去除警告*/
-(void)free;

-(void)setLabelTextUpdate:(NSString *)labelTextUpdate;

+(instancetype)labelInitWithSuperView:(UIView*)superView WithBlock:(void (^)(YMLabel *label))initBlock withLabelWithMas_makeConstraints:(MasonryMake)masonryMake;

//+(instancetype)labelInitWith:(void (^)(YMLabel *label))initBlock;

//+(instancetype)labelInitWithSuperView:(UIView*)superView WithBlock:(void (^)(YMLabel *label))initBlock;

//返回自适应sizeFree的方法*/
//-(void)labelWithMas_makeConstraints:(MasonryMake)masonryMake;

/** 设置某段字的颜色*/
- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length;

/** 设置某段字的字体*/
- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length;

/** 设置某段字的风格*/
- (void)setStyle:(CTUnderlineStyle)style fromIndex:(NSInteger)location length:(NSInteger)length;

/** 获取自适应的size*/
-(CGSize)sizeConfirmToSize:(CGSize)size;


@end
