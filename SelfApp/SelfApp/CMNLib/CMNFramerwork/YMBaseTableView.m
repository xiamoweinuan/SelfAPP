//
//  YMBaseTableView.m
//  YunMaiQ
//
//  Created by 高爽 on 17/3/13.
//  Copyright © 2017年 XR. All rights reserved.
//

#import "YMBaseTableView.h"
#import "YMTableViewCell.h"
@interface YMBaseTableView()

@end
@implementation YMBaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        
        
        _arrayCellIdentifiers = [NSMutableArray arrayWithCapacity:3];
        
    }
    return self;
}

-(void)registerClassWithTableView:(void (^)(YMBaseTableView* tableView))block{
    
    block(self);
    [self registerClass];//注册cell
    
}
-(Class)getClassWithIndex:(NSInteger)index{
    return NSClassFromString([_arrayCellIdentifiers objectAtIndex:index]);
}
-(void)registerClass{
    
    for (int i =0; i<self.arrayCellIdentifiers.count; i++) {
        
        Class object = NSClassFromString([self.arrayCellIdentifiers objectAtIndex:i]);
        
        [self registerClass:[object class] forCellReuseIdentifier:[object cellReuseIdentifier]];
    }
    
}

-(void)upDataWithModel:(id)model{
    
    
}
-(void)dealloc{
    if (self.arrayCellIdentifiers) {
        [self.arrayCellIdentifiers removeAllObjects];
    }
}

-(NSString*)getClassIdentifierWithIndex:(NSInteger)index{
    return [[self getClassWithIndex:index]cellReuseIdentifier];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
