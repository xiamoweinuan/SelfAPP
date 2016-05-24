//
//  EWPUIImageView.h
//  SelfApp
//
//  Created by andy on 16/5/3.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ImageBlock)(id sender);
@interface EWPUIImageView : UIImageView
@property (nonatomic,copy) ImageBlock imageBlock;

-(instancetype)initWithFrame:(CGRect)frame withImageName:(NSString*)imageName;
@end
