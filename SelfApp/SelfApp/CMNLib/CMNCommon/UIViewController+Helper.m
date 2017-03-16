//
//  UIViewController+Helper.m
//  YunMaiQ
//
//  Created by 高爽 on 17/3/9.
//  Copyright © 2017年 XR. All rights reserved.
//

#import "UIViewController+Helper.h"
#import "YMButton.h"
#import <objc/runtime.h>
@implementation ButtonItemCoutum
-(ButtonItemCoutum *(^)(TypeItem))button_Type{
    
    return ^ButtonItemCoutum* (TypeItem type){
        self.type = type;
        return self;
    };
}

//-(ButtonItemCoutum *(^)(CGFloat))button_SpaceDis{
//
//    return ^ButtonItemCoutum* (CGFloat spaceDis){
//
//        return self;
//    };
//
//
//}
-(ButtonItemCoutum *(^)(CGFloat))button_InsetsDis{
    
    return ^ButtonItemCoutum* (CGFloat insetsDis){
        
        [self setImageEdgeInsets:UIEdgeInsetsMake(0.0, insetsDis, 0.0, 0.0) ];
        return self;
    };
}

@end

@implementation UIViewController (Helper)

/** push指定页面*/
-(void)pushCanvas:(NSString *)canvasName withComplete:(void(^)(UIViewController*))comPlete{
    UIViewController* vc = [self getVc:canvasName];
    
    if (vc) {
        
        [self.navigationController pushViewController:vc animated:YES];
        
        if (comPlete) {
            comPlete(vc);
        }
        self.navigationController.hidesBottomBarWhenPushed = YES;
    }
}

/** pop到上一层 */
-(void)popCanvas{
    NSInteger vcCount = [self.navigationController.viewControllers count];
    
    if (vcCount >=2) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

/** pop到指定页面，canvasName为nil 则返回上一个vc*/
-(void)popToCanvas:(NSString *)canvasName withComplete:(void(^)(UIViewController*))comPlete{
    
    if (canvasName == nil) {
        [self popCanvas];
    }else{
        Class object = NSClassFromString(canvasName);
        
        for (UIViewController* canvasController in self.navigationController.viewControllers) {
            
            if (canvasController &&[canvasController isKindOfClass:[object class]]) {
                
                [self.navigationController popToViewController:canvasController animated:YES];
                
                if (comPlete) {
                    
                    comPlete(canvasController);
                }
                
            }
        }
        
    }
    
}

/** pop到根视图*/
-(void)popToRootCanvasWithArgmentWithComplete:(void(^)(UIViewController*))comPlete{
    
    UIViewController* canvasController =[self.navigationController.viewControllers objectAtIndex:0];
    
    if (canvasController) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        if (comPlete) {
            
            comPlete(canvasController);
        }
    }
}

-(UIViewController*)getVc:(NSString*)canvasName{
    return  [[NSClassFromString(canvasName) alloc]init];
    
}

-(void)setNavigationItem:(void (^)(ButtonItemCoutum* button))initBlock withBlock:(void (^)(TypeItem type) )block{
    
    ButtonItemCoutum* button = [ButtonItemCoutum buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(0, 0, 44, 44);
    if (initBlock) {
        initBlock(button);
    }
    __weak ButtonItemCoutum* buttonWeak = button;
    button.buttonBlock = ^(YMButton* sender){
        if (block) {
            block(buttonWeak.type);
        }
    };
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *itemSpacer = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                   target:nil action:nil];

    itemSpacer.width = button.button_SpaceDis;
    
    if (button.type == Type_Left) {
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:itemSpacer, item, nil];
    }else{
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: item,itemSpacer, nil];
    }
    
    
}




@end
