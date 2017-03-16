//
//  BaseViewController.m
//  YunMaiDriver
//
//  Created by 高爽 on 17/3/9.
//  Copyright © 2017年 YunMai. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

-(void)didRequestBlock:(RequestBlock)requestBlock  withComplete:(RequestComPleteBlock)requestComPleteBlock withRequestError:(RequestErrorBlock)requestErrorBlock{
    
    self.requestBlock = ^(id strMothod){
        if (requestBlock) {
            requestBlock(strMothod);
        }
    };
    
    self.requestComPleteBlock = ^(id data,NSString* strMothod) {
        if (requestComPleteBlock) {
            requestComPleteBlock(data,strMothod);
        }
    };
    
    self.requestErrorBlock = ^(NSError * error){
        if (requestErrorBlock) {
            requestErrorBlock(error);
        }
        
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
