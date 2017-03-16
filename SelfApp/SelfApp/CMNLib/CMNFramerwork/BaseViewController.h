//
//  BaseViewController.h
//  YunMaiDriver
//
//  Created by 高爽 on 17/3/9.
//  Copyright © 2017年 YunMai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RequestBlock)(id mothodMark);

typedef void (^RequestComPleteBlock)(id data,NSString* strMothod);

typedef void (^RequestErrorBlock)(NSError* error);

@interface BaseViewController : UIViewController


/** 请求成功*/
@property ( copy, nonatomic)RequestBlock requestBlock;

/** 请求的block*/
@property (copy, nonatomic) RequestComPleteBlock requestComPleteBlock ;

/** 请求失败*/
@property (copy, nonatomic)RequestErrorBlock requestErrorBlock;

/** commpleteBlock 
 data        返回的数据
 strMothod   返回数据所有权标记
 */
-(void)didRequestBlock:(RequestBlock)requestBlock  withComplete:(RequestComPleteBlock)requestComPleteBlock withRequestError:(RequestErrorBlock)requestErrorBlock;

@end
