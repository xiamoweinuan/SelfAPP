//
//  YMImageView.m
//  YunMaiQ
//
//  Created by 高爽 on 17/3/3.
//  Copyright © 2017年 XR. All rights reserved.
//

#import "YMImageView.h"

@implementation YMImageView


+(instancetype)imageViewInitWith:(InitBlock)initBlock withSuperView:(UIView *)superView withMasonryMake:(MasonryMakeImage)masonryMake{
    YMImageView* imageView = [[YMImageView alloc]init];
    initBlock(imageView);
    [superView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        masonryMake(make,imageView);
    }];
    
    return imageView;
}

+(instancetype)imageViewInitWith:(InitBlock)initBlock withSuperView:(UIView *)superView withMasonryMake:(MasonryMakeImage)masonryMake withImageBlock:(ImageBlock)imageBlock{
    
    YMImageView* imageView =[YMImageView imageViewInitWith:initBlock withSuperView:superView withMasonryMake:masonryMake];
    imageView.imageBlock = imageBlock;
    
    return imageView;
    
}

-(YMImageView *(^)(NSString *))imageName{
    return ^YMImageView* (NSString* imageName){
        self.image = [UIImage imageNamed:imageName];
        return self;
    };
}

-(void)setImageBlock:(ImageBlock)imageBlock{
    if (!_imageBlock) {
        self.userInteractionEnabled = YES;
        _imageBlock = imageBlock;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]init];
        [tap addTarget:self action:@selector(target)];
        [self addGestureRecognizer:tap];
    }
}
-(void)target{
    if (_imageBlock) {
        _imageBlock(self);
    }
}
-(YMImageView *(^)(UIImage *))imageImage{
    return ^YMImageView* (UIImage * image){
        self.image = image;
        return self;
    };
}

-(YMImageView *(^)(UIColor *))imageBackgroundColor{
    return ^YMImageView* (UIColor* color){
        self.backgroundColor = color;
        return self;
    };
}

-(YMImageView *(^)(UIColor *))buttonLayer_BorderColor{
    return ^YMImageView *(UIColor* color){
        self.layer.borderColor = color.CGColor;
        return self;
    };
}

-(YMImageView *(^)(CGFloat))buttonLayber_BorderWidth{
    return ^YMImageView* (CGFloat width){
        self.layer.borderWidth = width;
        return self;
    };
}

-(YMImageView *(^)(CGFloat))buttonLayer_BornerRadius{
    return ^YMImageView* (CGFloat radius){
        self.layer.cornerRadius = radius;
        return self;
    };
}

-(YMImageView *(^)(BOOL))buttonLayer_MaskToBounds{
    return ^YMImageView* (BOOL isToBounds){
        self.layer.masksToBounds = isToBounds;
        return self;
    };
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
