//
//  EWPLabel.m
//  SelfApp
//
//  Created by andy on 16/4/28.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "EWPLabel.h"

@implementation EWPLabel

-(instancetype)initWithSignleLabelWithText:(NSString*)text withFontSize:(CGFloat)fontSize withOriginX:(CGFloat)x withOriginY:(CGFloat)y isRelativeCoordinate:(BOOL)isRC{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        
        self.text = text;
        self.font = [UIFont systemFontOfSize:fontSize];
        [self sizeToFit];
        if (isRC) {
            self.center = CGPointMake(x+self.bounds.size.width/2, y+self.bounds.size.height/2);
        }else{
            self.center = CGPointMake(x,y);
        }
    }
    return self;
    
}
-(instancetype)initWithMoreLabelWithText:(NSString*)text withFontSize:(CGFloat)fontSize withBoundsWide:(CGFloat)boundsWide withOriginX:(CGFloat)x withOriginY:(CGFloat)y{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        
        self.text =text;
        self.numberOfLines = 0;
        self.font = [UIFont systemFontOfSize:fontSize];
        self.bounds = CGRectMake(0, 0, boundsWide, MAXFLOAT);
        [self sizeToFit];
        self.center = CGPointMake(x+self.bounds.size.width/2, y+self.bounds.size.height/2);
    }
    return self;
}

-(void)comSizeToFit{
    
    CGPoint point;
    point= self.center;
    [self sizeToFit];
    self.center = point;
    
}
-(void)comSizeToTextFit:(NSString*)textString{
    
    self.text = textString ;
    [self comSizeToFit];
    
}
-(void)setComSizeToTextFit:(NSString*)textString{
    self.text = textString ;
    
    [self comSizeToFit];
}


-(void)comFontSetCenter:(UIFont*)font{
    
    CGPoint point;
    point= self.center;
    self.font = font;
    [self sizeToFit];
    self.center = point;
    
}
@end
