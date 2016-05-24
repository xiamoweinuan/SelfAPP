//
//  ViewController.h
//  SelfApp
//
//  Created by andy on 16/3/31.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "BaseViewController.h"
typedef int(^compareBlock)(int a, int b);
@interface ViewController : BaseViewController



@property(nonatomic, copy) compareBlock compare;
@property(nonatomic, copy) UIView *(^viewGetter)(NSString *imageName); //注意其返回类型为UIView *

-(void)test:(compareBlock)block;

-(void)textWithBlock:(int (^)(int a, int b))blcok;
@end
