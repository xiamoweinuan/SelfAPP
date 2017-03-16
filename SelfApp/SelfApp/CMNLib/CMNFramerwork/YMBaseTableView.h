//
//  YMBaseTableView.h
//  YunMaiQ
//
//  Created by 高爽 on 17/3/13.
//  Copyright © 2017年 XR. All rights reserved.
//

#import "BaseTableView.h"

@interface YMBaseTableView : BaseTableView
//typedef void (^CellBlock)(NSString* str);
/** 注册的cell数组*/
@property (strong, nonatomic)NSMutableArray* arrayCellIdentifiers;

//@property (copy, nonatomic)CellBlock cellBlcokd;

/** block返回tableview实例，初始化没有完成的操作
 cellBlcok cell中传递数据需要
 */
-(void)registerClassWithTableView:(void (^)(YMBaseTableView* tableView))block;
//                    withCellBlock:(CellBlock)cellBlcok;


-(Class)getClassWithIndex:(NSInteger)index;

-(NSString*)getClassIdentifierWithIndex:(NSInteger)index;
@end
