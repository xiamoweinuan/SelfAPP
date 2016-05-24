//
//  EWPLabel.h
//  SelfApp
//
//  Created by andy on 16/4/28.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EWPLabel : UILabel
-(instancetype)initWithSignleLabelWithText:(NSString*)text withFontSize:(CGFloat)fontSize withOriginX:(CGFloat)x withOriginY:(CGFloat)y isRelativeCoordinate:(BOOL)isRC;
-(instancetype)initWithMoreLabelWithText:(NSString*)text withFontSize:(CGFloat)fontSize withBoundsWide:(CGFloat)boundsWide withOriginX:(CGFloat)x withOriginY:(CGFloat)y;

-(void)comSizeToFit;
-(void)comSizeToTextFit:(NSString*)textString;

-(void)comFontSetCenter:(UIFont*)font;

-(void)setComSizeToTextFit:(NSString*)textString;


@end
