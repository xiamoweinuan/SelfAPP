//
//  YMBaseViewController.m
//  YunMaiQ
//
//  Created by 高爽 on 17/3/9.
//  Copyright © 2017年 XR. All rights reserved.
//

#import "YMBaseViewController.h"
#import "UIViewController+Helper.h"

@interface YMBaseViewController ()
@property (copy, nonatomic)HeightForRowBlock heightForRowBlock;
@property (copy, nonatomic)HeightForHeaderBlock heightForheaderBlock;
@property (copy, nonatomic)HeightForFooterBlock heightForFooterBlock;
/** 返回行数*/
@property (copy, nonatomic)NumberRowsInSectionBlock rowsBlock;
/** 返回分区数*/
@property (copy, nonatomic)NumberSectionsBlock sectionsBlock;
/** (可选)返回定制的cell*/
@property (copy, nonatomic)CellBlcok cellBlock;

@property (copy, nonatomic)CellTouchBlock cellGetBlock;
/** 返回cell传值到vc的block*/
//@property (copy, nonatomic)CellTouch cellTouch;
/** 返回VC传值到cell的block*/
@property (copy, nonatomic)CellTouchBlock cellTouchBlock;
@end

@implementation YMBaseViewController
-(void)loadView{
    [super loadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /*如果view里包含scrollview，不设置此属性，会显示位置不正确。*/
    self.automaticallyAdjustsScrollViewInsets = NO;
    /*view里子视图如果不偏移64像素，会被覆盖*/
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    //    [self initRequestBlock];
    [self initUI];
    
    // Do any additional setup after loading the view.
}
-(void)initUI{
    CGRect rect = self.view.frame;
    rect.origin.y += 20;
    rect.size.height -= 20;
    self.view.frame = rect;
    if (self.baseViewType == ViewType_ScroolViewType)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_scrollView];
    }else if (self.baseViewType != ViewType_Default){
        
        UITableViewStyle style  = self.baseViewType==ViewType_TableViewType_Plan?UITableViewStylePlain:UITableViewStyleGrouped;
        _tableView = [[YMBaseTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-44) style:style];
        _tableView.backgroundColor = [UIColor redColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        //------默认开启下拉刷新，上拉加载
        _tableView.loadMore = YES;
        _tableView.refresh = YES;
    }
    
}

-(void)didRequestComplete:(id)data{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -tableViewDelgate

-(NSInteger)numberOfSectionsInBaseTableView:(YMBaseTableView *)baseTableView{
    
    __block NSInteger sectionsCount = 0;
    self.sectionsBlock=^(NSInteger setions){
        sectionsCount = setions;
    };
    self.sections(baseTableView,self.sectionsBlock);
    return 1;
}
-(NSInteger)baseTableView:(YMBaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section{
    __block NSInteger rowsCount =0;
    self.rowsBlock = ^(NSInteger rows){
        rowsCount = rows;
    };
    self.rows(baseTableView,section,self.rowsBlock);
    return 1;
}

-(UITableViewCell*)baseTableView:(YMBaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __block YMTableViewCell* cell = nil;
    cell = [baseTableView dequeueReusableCellWithIdentifier:[baseTableView getClassIdentifierWithIndex:indexPath.section] forIndexPath:indexPath];
    if (self.cellBlock) {
        self.cellBlock = nil;
    }
    self.cellBlock =^(YMTableViewCell* cellNew){//此处根据不同的tableview返回可选的cell
        cell = cellNew;
    };
    self.cell(baseTableView,cell,indexPath,self.cellBlock);//block中自定义cell
    
    if (cell.cellSendBlock) {
        cell.cellSendBlock = nil;
    }
    __weak __typeof(self) weakSelf = self;
    cell.cellSendBlock = ^(NSInteger tag , id data){
        [weakSelf getBlockType:@"touchBlock" withBlock:weakSelf.cellTouchBlock withRow:indexPath.row withSection:indexPath.section withTableView:baseTableView withTag:tag withData:data];
    };
    
    return cell;
    
}

- (CGFloat)baseTableView:(YMBaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __block NSInteger height =0;
    
    
    height =  [[baseTableView getClassWithIndex:indexPath.section] heightForCellData:nil atIndexPath:indexPath] ;
    if (self.heightForRowBlock) {
        
        self.heightForRowBlock = nil;
    }
    
    self.heightForRowBlock = ^(CGFloat cellHeight){
        height = cellHeight;
    };
    [self getBlockType:@"cellHeight" withBlock:self.heightForRowBlock withRow:indexPath.row withSection:indexPath.section withTableView:baseTableView withTag:0 withData:nil];
    return height;
}
- (CGFloat)baseTableView:(YMBaseTableView *)baseTableView heightForHeaderInSection:(NSInteger)section{
    __block NSInteger height =0;
    if (self.heightForheaderBlock) {
        self.heightForheaderBlock = nil;
    }
    self.heightForheaderBlock = ^(CGFloat cellHeight){
        height = cellHeight;
    };
    
    
    [self getBlockType:@"headerHeight" withBlock:self.heightForheaderBlock withRow:0 withSection:section withTableView:baseTableView withTag:0 withData:nil];
    return height;
}

- (CGFloat)baseTableView:(YMBaseTableView *)baseTableView heightForFooterInSection:(NSInteger)section{
    
    __block NSInteger height =0;
    if (self.heightForFooterBlock) {
        self.heightForFooterBlock = nil;
    }
    self.heightForFooterBlock = ^(CGFloat cellHeight){
        height = cellHeight;
    };
    [self getBlockType:@"footerHeight" withBlock:self.heightForFooterBlock withRow:0 withSection:section withTableView:baseTableView withTag:0 withData:nil];
    return height;
}
-(void)getBlockType:(NSString*)strMark withBlock:(id)block withRow:(NSInteger)row withSection:(NSInteger)section withTableView:(YMBaseTableView*)tableView withTag:(NSInteger)tag withData:(id)data{
    
    self.cellTouchBlock = nil;
    self.heightForheaderBlock = nil;
    self.heightForRowBlock = nil;
    self.heightForFooterBlock = nil;
    NSInteger tagTarget = 0;
    id dataTarget = nil;
    NSInteger rowTarget = 0;
    NSInteger sectionTarget = 0;
    YMBaseTableView* tableViewTarget = nil;
    
    if ([strMark isEqualToString:@"touchBlock"]) {
        self.cellTouchBlock = block;
        tagTarget = tag;
        dataTarget = data;
        
    }else if([strMark isEqualToString:@"cellHeight"]){
        self.heightForRowBlock = block;
        sectionTarget = sectionTarget;
        rowTarget = row;
        tableViewTarget = tableView;
        
    }else if([strMark isEqualToString:@"headerHeight"]) {
        self.heightForheaderBlock = block;
        sectionTarget = sectionTarget;
        tableViewTarget = tableView;
    }else if ([strMark isEqualToString:@"footerHeight"]){
        self.heightForFooterBlock = block;
        sectionTarget = sectionTarget;
        tableViewTarget = tableView;
        
    }
    self.otherItems(self.heightForRowBlock,self.heightForheaderBlock,self.heightForFooterBlock,rowTarget,sectionTarget,tableViewTarget,self.cellTouchBlock,tag,data);
}

-(void)tableViewDelegateWithSections:(Sections)sections withRows:(Rows)rows withTableViewCell:(Cell)cell withOtherItems:(OtherItems)otherItems{
    
    if (sections) {
        self.sections = sections;
    }
    
    if (rows) {
        self.rows = rows;
    }
    if (cell){
        self.cell = cell;
        
    }
    if (otherItems) {
        self.otherItems = otherItems;
    }
}
-(void)dealloc{
    
    if(_tableView){
        [_tableView free];
    }
    if (_scrollView) {
        [_scrollView removeFromSuperview];
        _scrollView = nil;
    }
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
