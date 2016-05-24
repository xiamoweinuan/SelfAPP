//
//  EWPUIImageView.m
//  SelfApp
//
//  Created by andy on 16/5/3.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "EWPUIImageView.h"

@implementation EWPUIImageView
-(instancetype)initWithFrame:(CGRect)frame withImageName:(NSString*)imageName{
    self = [super initWithFrame:frame];
    if (self) {
        if (imageName) {
            [self setImage:[UIImage imageNamed:imageName]];
        }
    }
    return self;
}

-(void)setImageBlock:(ImageBlock)imageBlock{
    if (imageBlock)
    {
        _imageBlock = nil;
        _imageBlock = [imageBlock copy];
    self.userInteractionEnabled = YES;
    UIControl* control =[[UIControl alloc]initWithFrame:self.frame];
    [control addTarget:self action:@selector(contro) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:control];
    }
}
-(void)contro{
    if (_imageBlock) {
        _imageBlock (self);
    }
}
@end
