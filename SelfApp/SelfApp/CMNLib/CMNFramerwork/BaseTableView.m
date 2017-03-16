//
//  BaseTableView.m
//  YunMaiQ
//
//  Created by 高爽 on 17/3/9.
//  Copyright © 2017年 XR. All rights reserved.
//

#import "BaseTableView.h"


@implementation BaseTableView


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self initUI:frame];
    }
    return self;
}

- (void)initUI:(CGRect)frame
{
    self.dataSource = self;
    self.delegate = self;
    self.curentPage = 1;
    self.totalPage = 1;
    self.backgroundColor = [UIColor clearColor];
    
}
- (void)free
{
    if (self.mj_header)
    {
        [self.mj_header removeFromSuperview];
        self.mj_header = nil;
    }
    
    if (self.mj_footer)
    {
        [self.mj_footer removeFromSuperview];
        self.mj_footer = nil;
    }
    self.delegate = nil;
    self.dataSource = nil;
    [self removeFromSuperview];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 刷新控件复位
    if (self.mj_header&& [self.mj_header  isRefreshing])
    {
        [self.mj_header endRefreshing];
    }
    
    if (self.mj_footer&& [self.mj_footer isRefreshing])
    {
        [self.mj_footer endRefreshing];
    }
    
    NSInteger nCount = 0;
    if (self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(numberOfSectionsInBaseTableView:)]) {
        nCount =  [self.baseDataSource numberOfSectionsInBaseTableView:self];
    }
    return nCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger nCount = 0;
    if (self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(baseTableView:numberOfRowsInSection:)])
    {
        nCount = [self.baseDataSource baseTableView:(BaseTableView *)tableView numberOfRowsInSection:section];
        if (nCount > 0) {
            //            _tipContent.text = @"";
        }
    }
    return nCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(baseTableView:cellForRowAtIndexPath:)])
    {
        return [self.baseDataSource baseTableView:(BaseTableView *)tableView cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(baseTableView:canEditRowAtIndexPath:)])
    {
        return [self.baseDataSource baseTableView:(BaseTableView *)tableView canEditRowAtIndexPath:indexPath];
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(baseTableView:commitEditingStyle:forRowAtIndexPath:)])
    {
        [self.baseDataSource baseTableView:(BaseTableView *)tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(baseTableView:titleForHeaderInSection:)])
    {
        return  [self.baseDataSource baseTableView:self titleForHeaderInSection:section];
    }
    return nil;
}

#pragma mark - Table view delegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:willSelectRowAtIndexPath:)])
    {
        return [self.baseDelegate baseTableView:(BaseTableView *)tableView willSelectRowAtIndexPath:indexPath];
    }
    return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:willDeselectRowAtIndexPath:)])
    {
        return [self.baseDelegate baseTableView:(BaseTableView *)tableView willDeselectRowAtIndexPath:indexPath];
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:didSelectRowAtIndexPath:)])
    {
        [self.baseDelegate baseTableView:(BaseTableView *)tableView didSelectRowAtIndexPath:indexPath];
    }
    if (self.baseCustomDelegate && [self.baseCustomDelegate respondsToSelector:@selector(baseTableView:didSelectRowAtIndexPath:)])
    {
        [self.baseCustomDelegate baseTableView:(BaseTableView *)tableView didSelectRowAtIndexPath:indexPath];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0f;
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:heightForRowAtIndexPath:)])
    {
        height = [self.baseDelegate baseTableView:(BaseTableView *)tableView heightForRowAtIndexPath:indexPath];
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat headheight = 0.0f;
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:heightForHeaderInSection:)])
    {
        headheight = [self.baseDelegate baseTableView:(BaseTableView *)tableView heightForHeaderInSection:(section)];
    }
    
    return headheight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat headheight = 0.0f;
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:heightForFooterInSection:)])
    {
        headheight = [self.baseDelegate baseTableView:(BaseTableView *)tableView heightForFooterInSection:(section)];
    }
    
    return headheight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = nil;
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:viewForHeaderInSection:)])
    {
        view = [self.baseDelegate baseTableView:(BaseTableView *)tableView viewForHeaderInSection:section];
    }
    
    return view;
}


- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = nil;
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:viewForFooterInSection:)])
    {
        view = [self.baseDelegate baseTableView:(BaseTableView *)tableView  viewForFooterInSection:section];
    }
    
    return view;
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:willDisplayCell:forRowAtIndexPath:)])
    {
        [self.baseDelegate baseTableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}



-(void)requestRefershType:(RequestRefershType)requestRefershType{
    self.requestRefershType = ^(RefershType type){
        if (requestRefershType) {
            requestRefershType(type);
        }
    };
}

#pragma mark - refresh

- (void)setLoadMore:(BOOL)loadMore
{
    _loadMore = loadMore;
    
    if (loadMore == YES)
    {
        if (self.mj_footer) {
            self.mj_footer.hidden = NO;
        }else{
            
            __weak typeof(self) weakSelf = self;
            self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                
                if (weakSelf.requestRefershType) {
                    
                    if (weakSelf.curentPage <weakSelf.totalPage) {
                        weakSelf.requestRefershType(Type_loadmore);
                        [weakSelf sendRequestRefershDeleageWith:Type_loadmore];
                        weakSelf.totalPage++;
                        
                    }else {
                        //                        weakSelf.requestRefershType(Type_noData);//上拉没有数据了
                        //                        weakSelf.loadMore = NO;//去掉上拉加载
                        //                        [weakSelf sendRequestRefershDeleageWith:Type_noData];
                    }
                }
                
                
            }];
        }
    }
    else
    {
        [self.mj_footer removeFromSuperview];
        self.mj_footer = nil;
    }
}

- (void)setRefresh:(BOOL)refresh
{
    _refresh = refresh;
    if (refresh == YES)
    {
        
        if (self.mj_header) {
            self.mj_header.hidden = NO;
        }else{
            __weak typeof(self) weakSelf = self;
            self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                
                if (weakSelf.requestRefershType) {
                    weakSelf.requestRefershType(Type_refersh);
                    [weakSelf sendRequestRefershDeleageWith:Type_refersh];
                }
                weakSelf.curentPage = 1;
                
                if (weakSelf.loadMore && !weakSelf.mj_footer) {//如果支持上拉加载，复位
                    [weakSelf setLoadMore:YES];
                }
                
            }];
        }
    }
    else
    {
        self.mj_header.hidden = YES;
    }
    
    
}

-(void)sendRequestRefershDeleageWith:(RefershType)type{
    if (self.baseCustomDelegate && [self.baseCustomDelegate respondsToSelector:@selector(requestRefershTypeDelegate:)]) {
        [self.baseCustomDelegate requestRefershTypeDelegate:type];
    }
}





/*老版本MJ刷新
 #pragma mark - MJRefreshBaseViewDelegate
 
 - (BOOL)shouldRefresh:(MJRefreshBaseView *)refreshView
 {
 BOOL bRet = YES;
 if (refreshView == _header)
 {
 bRet =  YES;
 }
 else
 {
 if (_curentPage == _totalPage)
 {
 if(self.contentOffset.y >0)
 {
 bRet = NO;
 }
 else
 {
 bRet = YES;
 }
 }
 else
 {
 bRet = YES;
 }
 }
 return bRet;
 }
 - (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView{
 
 if (_footer == refreshView) {
 [self setContentOffset:CGPointMake(0, self.contentSize.height -self.bounds.size.height) animated:NO];
 if (self.curentPage >= self.totalPage) {
 
 [self performSelector:@selector(setLoadM) withObject:nil afterDelay:0.2];
 }
 }
 
 }
 -(void)setLoadM{
 self.loadMore = NO;
 }
 - (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
 {
 
 if (_header == refreshView)
 {
 
 self.reloadType = krefreshData;
 if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(refreshData)]) {
 _curentPage = 1;
 [self.baseDelegate refreshData];
 
 }
 if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(didRequestType:)]) {
 _curentPage = 1;
 [self.baseDelegate didRequestType:krefreshData];
 }
 
 
 if (self.baseCustomDeleate && [self.baseCustomDeleate respondsToSelector:@selector(didRequestType:)]) {
 _curentPage = 1;
 [self.baseCustomDeleate didRequestType:krefreshData];
 }
 
 }
 else
 {
 BOOL isAddEd = NO;
 self.reloadType = kloadMorData;
 if ( _curentPage < _totalPage)
 {
 
 if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(loadMorData)]) {
 _curentPage++;
 isAddEd = YES;
 [self.baseDelegate loadMorData];
 }
 
 if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(didRequestType:)]) {
 if (!isAddEd) {
 _curentPage++;
 }
 
 [self.baseDelegate didRequestType:kloadMorData];
 isAddEd = YES;
 
 }
 
 if (self.baseCustomDeleate && [self.baseCustomDeleate respondsToSelector:@selector(didRequestType:)]) {
 if (!isAddEd) {
 _curentPage++;
 }
 [self.baseCustomDeleate didRequestType:kloadMorData];
 isAddEd = YES;
 }
 }
 else
 {
 
 
 [self performSelector:@selector(reloadData) withObject:nil afterDelay:0.1];//等待tableView代理方法调用过后
 
 //------自定义的footerView
 //            [self.tableFooterView removeFromSuperview];
 //            UIView* view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 84)];
 //            view.backgroundColor =[UIColor redColor];
 //            self.tableFooterView = view;
 
 //------自定义的提示
 
 //            [self MsgBox:@"\n已经是最后一页"];
 //            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self.tableView selector:@selector(reloadData) userInfo:nil repeats:NO];
 //            [_footer free];
 
 }
 
 }
 }
 
 -(void)beginRefreshing{
 if ([self shouldRefresh:_header]) {
 //------等待tableView代理方法调用过后
 [self performSelector:@selector(startRefreshing) withObject:nil afterDelay:0.1];
 }
 }
 -(void)startRefreshing{
 [_header beginRefreshing];
 }
 *
 /*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
@end
