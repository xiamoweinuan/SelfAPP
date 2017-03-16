//
//  YMBaseViewController.h
//  YunMaiQ
//
//  Created by 高爽 on 17/3/9.
//  Copyright © 2017年 XR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMBaseTableView.h"
#import "YMTableViewCell.h"
typedef enum _BaseViewType
{
    ViewType_Default,  //默认vc的view
    ViewType_ScroolViewType,//scroolView
    ViewType_TableViewType_Plan,//UITableViewStylePlan
    ViewType_TableViewType_Group,//UITableViewStyleGroupe
    
}BaseViewType;


@interface YMBaseViewController : UIViewController<UIScrollViewDelegate>

/**默认类型是BaseViewType，是没有scrollview，此时scrollview为空
 使用的话，[super viewDidLoad]之前需要指定类型
 */
@property (nonatomic,assign) BaseViewType baseViewType;

/**如果基于scrollview的话，将内容加到scrollview，不需要手动创建*/
@property (nonatomic,strong) UIScrollView *scrollView;

/**如果子视图包含tableview的话，默认tableview的大小和view的大小一样，可以自己设置大小*/
@property (nonatomic,strong) YMBaseTableView *tableView;

/**当是类型为kbaseTableViewType时，子视图包含tableview，并且默认是支持上拉加载，下拉刷新*/

@property (nonatomic,assign) BOOL refresh;
@property (nonatomic,assign) BOOL loadMore;



typedef void (^NumberRowsInSectionBlock)(NSInteger rows);
typedef void (^NumberSectionsBlock)(NSInteger sections);
typedef void (^CellBlcok)(YMTableViewCell* cell);
typedef void (^CellTouchBlock)(NSInteger tag, id data);
typedef void (^HeightForRowBlock)(CGFloat height);
typedef void (^HeightForHeaderBlock)(CGFloat height);
typedef void (^HeightForFooterBlock)(CGFloat heitht);

typedef void (^Sections)(YMBaseTableView* tableView,NumberSectionsBlock sectionsBlock);
typedef void (^Rows)(YMBaseTableView* tableView,NSInteger section,NumberRowsInSectionBlock rowsBlock);
typedef void (^CellTouch)(NSInteger Tag,id data,CellTouchBlock cellTouchBlock);
typedef void (^Cell)(YMBaseTableView* tableView,YMTableViewCell* cell,NSIndexPath* indexPath,CellBlcok cellBlock);
/** heightForRowBlock  行高
 heightForheaderBlock  header高度
 heightForFooterBlock  footer高度
 row    所在行
 section    所在分区
 tableView    当前所属tableView
 cellTouchBlock 接受cell传值的block
 tag    cell传值tag
 data   cell传值data
 */
typedef void (^OtherItems)(HeightForRowBlock heightForRowBlock,HeightForHeaderBlock heightForheaderBlock,HeightForFooterBlock heightForFooterBlock,NSInteger row,NSInteger section,YMBaseTableView* tableView,CellTouchBlock cellTouchBlock, NSInteger tag, id data);

/** 返回rows的代理方法参数 并返回一个block*/
@property (copy, nonatomic)Rows rows;
/** 返回sections的代理方法参数 并返回一个block*/
@property (copy, nonatomic)Sections sections;
/** 返回cell的代理方法参数 并(可选)返回一个cell*/
@property (copy, nonatomic)Cell cell;
@property (copy, nonatomic)OtherItems otherItems;
/** sections 返回sections代理的参数并提交一个行数
 rows  返回row代理的参数并提交一个行数
 cell  返回cell代理参数，可选重新定义一个cell
 otherItems 返回行高，header，footer高度，以及cell的回调
 */
-(void)tableViewDelegateWithSections:(Sections)sections withRows:(Rows)rows withTableViewCell:(Cell)cell withOtherItems:(OtherItems)otherItems;



//网络
//-(void)postCoutomMethod:(NSString*)url parameters:(id)dic  withModelClass:(Class)modelClass success:(XRSuccessBlock)succes failure:(XRFailureBlock)fail{
//
//
//    [self.httpRequestOperationManager POST:url parameters:dic success:^(id responseObject) {
//        [self customJastorWithData:responseObject withModelClass:modelClass withSuccess:succes];
//    } failure:fail];
//
//}
//-(void)customJastorWithData:(id)data withModelClass:(Class)modelClass withSuccess:(XRSuccessBlock)succes{
//
//    succes([modelClass objectFromDictionary:data[@"data"]]);
//
//}


@end
