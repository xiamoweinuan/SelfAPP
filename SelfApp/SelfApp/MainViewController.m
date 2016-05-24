//
//  MainViewController.m
//  SelfApp
//
//  Created by andy on 16/3/31.54j
//  Copyright © 2016年 andy. All rights reserved.
//

#import "MainViewController.h"
#import "SuperID.h"
@interface MainViewController ()

@end

@implementation MainViewCont20roller

- (void)viewDidLoad {
    [super viewDidLoad];
        [SuperID sharedInstance].delegate = self;
    NSError *error = nil;
    
    id SIDLoginViewController = [[SuperID sharedInstance]obtainLoginViewControllerWithError:&error];
    
    if (SIDLoginViewController) {
        
        [self presentViewController:SIDLoginViewController animated:YES completion:nil];
        
    }else{
    
        NSLog(@"Error =%ld,%@",(long)[error code],[error localizedDescription]);
    }

    
    EWPLabel* label = [[EWPLabel alloc]initWithSignleLabelWithText:@"sdfadfaf" withFontSize:12 withOriginX:100 withOriginY:100 isRelativeCoordinate:YES];
    [self.view addSubview:label];
    label.frame = CGRectMake(200, 200, 200, 200);
    EWPButton* button =[EWPButton buttonWithButtonWithFrame:CGRectMake(0, 0, 100, 100) withButtonBlock:^(EWPButton* sender){
        
    }];
  
    button.backgroundColor =[UIColor blueColor];
    button.titleStrNormal = @"dsfas";
    button.colorTitleSelect =[UIColor blackColor];
    button.autotoggleEnabled = YES;
    [button setIamgeNormalBackgroundImage:[button imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"]]];
    [button setIamgeHighlightedBackgroundImage:IMAGE(@"ffffff", 100, 100)];
    [label addSubview:button];
    
    
    
    NSLog(@"%f",CGRectGetMinX(button.frame));
    NSLog(@"%f111f",button.frameX);
    
    
    // Do any additional setup after loading the view.
}
- (void)superID:(SuperID *)sender userDidFinishLoginWithUserInfo:(NSDictionary *)userInfo withOpenId:(NSString *)openId error:(NSError *)error{
    
    if (!error) {
        
        //授权登录成功
        NSLog(@"userInfo:%@", userInfo);
        NSLog(@"openId = %@", openId);
        
    }else{
        
        //授权登录失败
        NSLog(@"Login Fail Error =%ld,%@",(long)[error code],[error localizedDescription]);
    }
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
