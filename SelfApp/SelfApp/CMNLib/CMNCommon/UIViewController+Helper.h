//
//  UIViewController+Helper.h
//  YunMaiQ
//
//  Created by 高爽 on 17/3/9.
//  Copyright © 2017年 XR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMButton.h"
typedef enum{
    Type_Left,
    Type_Right,
}TypeItem;
@interface ButtonItemCoutum : YMButton


@property (assign, nonatomic)TypeItem type;

/** left right按钮type*/
@property (copy, nonatomic)ButtonItemCoutum *(^button_Type)(TypeItem type);

/** 按钮图片上下调整*/
@property (copy, nonatomic)ButtonItemCoutum *(^button_InsetsDis)(CGFloat insetsDis);


/** 按钮图片左右调整*/

@property (assign, nonatomic)CGFloat button_SpaceDis;
//@property (copy, nonatomic)ButtonItemCoutum *(^button_SpaceDis)(CGFloat spaceDis); ;

@end



@interface UIViewController (Helper)

/** push指定页面*/
-(void)pushCanvas:(NSString *)canvasName withComplete:(void(^)(UIViewController*))comPlete;

/** pop到上一层 */
-(void)popCanvas;

/** pop到指定页面，canvasName为nil 则返回上一个vc*/
-(void)popToCanvas:(NSString *)canvasName withComplete:(void(^)(UIViewController*))comPlete;

/** pop到根视图*/
-(void)popToRootCanvasWithArgmentWithComplete:(void(^)(UIViewController*))comPlete;


/**设置navigationcontroller左右按钮
    initBlock返回的ButtonItemCoutum可以自定义
    block 点击方法回调
 */
-(void)setNavigationItem:(void (^)(ButtonItemCoutum* button))initBlock withBlock:(void (^)(TypeItem type) )block;


@end



