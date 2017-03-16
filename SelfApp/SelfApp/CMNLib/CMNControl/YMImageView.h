//
//  YMImageView.h
//  YunMaiQ
//
//  Created by 高爽 on 17/3/3.
//  Copyright © 2017年 XR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface YMImageView : UIImageView
typedef void (^MasonryMakeImage)(MASConstraintMaker *make,YMImageView* button);
typedef void (^ImageBlock)(YMImageView* button);
typedef void (^InitBlock)(YMImageView* button);


@property (nonatomic ,copy)YMImageView* (^imageName)(NSString* imageNme);

@property (nonatomic ,copy)YMImageView* (^imageImage)(UIImage* image);

@property (nonatomic, copy)YMImageView* (^imageBackgroundColor)(UIColor* color);

@property (nonatomic, copy)MasonryMakeImage masonryMakeImage;

@property (nonatomic, copy)ImageBlock imageBlock;

@property (nonatomic, copy)InitBlock initBlock;

@property (nonatomic, copy)YMImageView* (^image_BornerRadius)(CGFloat radius);

@property (nonatomic, copy)YMImageView* (^image_MaskToBounds)(BOOL isToBounds);

@property (nonatomic, copy)YMImageView* (^image_BorderWidth)(CGFloat width);

@property (nonatomic, copy)YMImageView* (^image_BorderColor)(UIColor* color);

@property (nonatomic, copy)YMImageView* (^imageTag)(NSInteger tag);


+(instancetype)imageViewInitWith:(InitBlock)initBlock withSuperView:(UIView*)superView withMasonryMake:(MasonryMakeImage)masonryMake;


+(instancetype)imageViewInitWith:(InitBlock)initBlock withSuperView:(UIView*)superView withMasonryMake:(MasonryMakeImage)masonryMake withImageBlock:(ImageBlock)imageBlock;


@end
