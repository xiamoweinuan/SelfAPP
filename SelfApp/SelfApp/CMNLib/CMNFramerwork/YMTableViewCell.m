//
//  YMTableViewCell.m
//  YunMaiQ
//
//  Created by 高爽 on 17/3/13.
//  Copyright © 2017年 XR. All rights reserved.
//

#import "YMTableViewCell.h"

@implementation YMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
    }
    return self;
}
-(void)updateWithCellData:(id)aData atIndexPath:(NSIndexPath *)indexPath{
    
}
+ (NSString *)cellReuseIdentifier{
     return NSStringFromClass([self class]);
}

- (UITableView *)__getTableView
{
    static int level = 10;
    UITableView *tableView = nil;
    
    UIView *view = self.superview;
    for (int i = 0; i < level; i++) {
        if ([view isKindOfClass:[UITableView class]]) {
            tableView = (UITableView *)view;
            break;
        }
        if (view.superview) {
            view = view.superview;
        }
        else {
            break;
        }
    }
    
    return tableView;
}
- (NSIndexPath *)indexPath
{
    if (_indexPath) {
        return _indexPath;
    }
    
    _indexPath = [[self __getTableView] indexPathForCell:self];
    return _indexPath;
}
+(CGFloat)heightForCellData:(id)aData atIndexPath:(NSIndexPath *)indexPath{
    
    return 0;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
