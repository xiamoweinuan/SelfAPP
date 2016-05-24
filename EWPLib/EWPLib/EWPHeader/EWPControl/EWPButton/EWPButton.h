//
//  EWPButton.h
//  MemberMarket
//
//  Created by jiangbin on 13-11-18.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IMAGE(colorStr,sizeWide,sideHight)   [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:colorStr] size:CGSizeMake(sizeWide, sideHight)]
/*ButtonBlock*/
typedef void(^ButtonBlock)(id sender);

/*对UIButton的扩展，如果设置了buttonBlockde 的话，原来的action将被移除*/

@interface EWPButton : UIButton

@property(nonatomic,copy) ButtonBlock buttonBlock;
@property (assign,nonatomic) BOOL isSoonCliCKLimit;

@property(strong, nonatomic)NSString* titleStrNormal;

@property(strong, nonatomic)UIImage* iamgeNormalBackgroundImage;
@property(strong, nonatomic)UIImage* iamgeHighlightedBackgroundImage;



@property(strong, nonatomic)UIColor* colorNormalTitleColor;
@property(strong, nonatomic)UIColor* colorHighlightedTitleColor;

/*选中状态下的图片*/
@property(strong, nonatomic)UIImage* iamgeSelect;
/*选中状态下的标题颜色*/
@property(strong, nonatomic)UIColor* colorTitleSelect;
/*选中状态下的标题*/
@property(strong, nonatomic)NSString* titleSelect;

/*是否开启选中切换*/
@property (nonatomic,assign) BOOL autotoggleEnabled;
/*当前选中状态*/
@property (nonatomic,assign) BOOL select;


//-(instancetype)initWithButtonWithFrame:(CGRect)frame withButtonBlock:(ButtonBlock)buttonBlocck;
+(instancetype)buttonWithButtonWithFrame:(CGRect)frame withButtonBlock:(ButtonBlock)buttonBlocck;

+(instancetype)buttonWithButtonWithFrame:(CGRect)frame withTitle:(NSString*)title withFontSize:(CGFloat)size withTitleClor:(UIColor*)color withButtonBlock:(ButtonBlock)buttonBlocck;


-(void)colorNormalTitleColor:(UIColor*)colorNor withcolorHighlightedTitleColor:(UIColor*)colorHigh;
-(void)iamgeNormalBackgroundImage:(UIImage*)imageNor withIamgeHighlightedBackgroundImage:(UIImage*)imageHigh;

- (UIImage *)imageWithColor:(UIColor *)color;
@end
