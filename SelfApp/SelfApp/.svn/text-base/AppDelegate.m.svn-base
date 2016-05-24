//
//  AppDelegate.m
//  SelfApp
//
//  Created by andy on 16/3/31.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "SuperID.h"

#define SIDAPPID        @"c9b07d63d71436cf5e58de3f"
#define SIDAPPSECRET    @"7765d82c0c5370ba7b80e164"
@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    MainViewController* mainViewController  =[[MainViewController alloc]init];
      _navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    _lrSliderMenuViewController = [[EWPSliderMenuViewController alloc] initWithRootViewController:_navigationController leftViewController:nil rightViewController:nil];
    _lrSliderMenuViewController.view.backgroundColor = [UIColor whiteColor];
       self.window.rootViewController = _lrSliderMenuViewController;
    
    [[SuperID sharedInstance]registerAppWithAppID:@"AppID" withAppSecret:@"AppSecret"];
    
    //开启SuperID SDK的调试模式，开发者在Release时，将该模式设置为NO.
    [SuperID setDebugMode:YES];
    //设置一登 SDK 的语言模式，默认为自动模式。
    [SuperID setLanguageMode:SIDAutoMode];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Split view



@end
