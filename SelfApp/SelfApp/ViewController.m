//
//  ViewController.m
//  SelfApp
//
//  Created by andy on 16/3/31.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(self) weakSelf = self;
    self.viewGetter = ^(NSString *imageName){
        //        return [[UIView alloc] init]; //特别注意此处，若对象不匹配，则会报错，设置为nil也会报错。
        return [weakSelf currentView];
    };
    self.viewGetter(@"hello"); //实际执行block
    
    
    

    self.compare = ^(int a,int b)
    {
        int result = [weakSelf maxer:a another:b];
        NSLog(@"the result is %d",result);
        return result;
    };
    NSLog(@"the properBlockObj.compare is %d",self.compare(100,200));
    
    
  

   
}





- (UIView *)currentView
{
    NSLog(@"now I am in currentView");
    return nil;
}

- (int)maxer:(int)a another:(int)b
{
  
    if (a > b) {
        return a;
    }
    return  b;
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
