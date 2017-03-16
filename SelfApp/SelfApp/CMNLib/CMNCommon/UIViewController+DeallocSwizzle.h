//
//  UIViewController+DeallocSwizzle.h
//  YunMaiDriver
//
//  Created by 高爽 on 17/3/8.
//  Copyright © 2017年 YunMai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DeallocSwizzle)
@property (copy, nonatomic) NSString *method;
@end
