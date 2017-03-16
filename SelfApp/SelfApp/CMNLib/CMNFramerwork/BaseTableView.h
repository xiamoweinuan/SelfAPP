//
//  BaseTableView.h
//  YunMaiQ
//
//  Created by 高爽 on 17/3/9.
//  Copyright © 2017年 XR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MJRefresh.h"

typedef enum _ReloadType
{
    Type_refersh,
    
    Type_loadmore,
    
    Type_noData,
    
}RefershType;//刷新方式

@class BaseTableView;

@protocol BaseTableViewDataSoure <NSObject>

@required

- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView;

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (BOOL)baseTableView:(BaseTableView *)baseTableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)baseTableView:(BaseTableView *)baseTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)baseTableView:(BaseTableView *)baseTableView titleForHeaderInSection:(NSInteger)section;

@end

@protocol BaseTableViewDelegate <NSObject>

@optional
- (NSIndexPath *)baseTableView:(BaseTableView *)baseTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)baseTableView:(BaseTableView *)baseTableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForHeaderInSection:(NSInteger)section;

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForFooterInSection:(NSInteger)section;

- (UIView *)baseTableView:(BaseTableView *)baseTableView viewForHeaderInSection:(NSInteger)section;

- (UIView *)baseTableView:(BaseTableView *)baseTableView viewForFooterInSection:(NSInteger)section;

- (void)baseTableView:(UITableView *)baseTableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

///*上拉加载更多数据*/
//- (void)loadMorData;
//
///*下拉刷新最新数据*/
//- (void)refreshData;
//
///*下拉刷，上拉加载*/
//- (void)didRequestType:(RefershType)reloadType;

@end



typedef void (^RequestRefershType)(RefershType type);

/*BaseCustomDeleate中方法可以不局限于LSBaseDatasource中实现*/
@protocol BaseCustomDelegate <NSObject>

@optional
-(void)requestRefershTypeDelegate:(RefershType)requestRefershType;

- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


/*TableViewde的基类，包含上拉加载，下拉刷新，提示语*/
@interface BaseTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

/*当是类型为kbaseTableViewType时，子视图包含tableview，并且默认是支持上拉加载，下拉刷新*/
/*控制tableviewheader*/
@property (nonatomic,assign) BOOL refresh;
/*控制tableview foot*/
@property (nonatomic,assign) BOOL loadMore;
/*当前刷新的类型*/
@property (nonatomic,assign) RefershType refershType;

@property (nonatomic,copy) RequestRefershType requestRefershType;
/*当前页*/
@property(nonatomic,assign) NSInteger curentPage;
/*总页数*/
@property(nonatomic,assign) NSInteger totalPage;

@property(nonatomic,weak) id<BaseTableViewDataSoure> baseDataSource;

@property(nonatomic,weak) id<BaseTableViewDelegate>  baseDelegate;

@property(nonatomic,weak) id<BaseCustomDelegate>  baseCustomDelegate;

-(void)requestRefershType:(RequestRefershType)requestRefershType;

- (void)free;

//*数据为空提示语*/
//@property(nonatomic,strong) UILabel *tipContent;
//*数据为空的view*/
//@property(nonatomic,strong) UIControl *controlNoDataView;
//- (void)free;
///**手动让tableView刷新 */
//-(void)beginRefreshing;

@end
