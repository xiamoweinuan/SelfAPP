//
//  YMTableViewCell.h
//  YunMaiQ
//
//  Created by 高爽 on 17/3/13.
//  Copyright © 2017年 XR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMTableViewCell : UITableViewCell

typedef void (^CellGetBlock)(NSInteger tag, id data);
//typedef void (^CellTouch)(NSInteger Tag,id data,CellTouchBlock cellTouchBlock);
/**
 *  index
 */
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (copy, nonatomic)CellGetBlock cellGetBlock;
@property (copy, nonatomic)CellGetBlock cellSendBlock;
- (void)updateWithCellData:(id)aData atIndexPath:(NSIndexPath *)indexPath;
/**
 *  功能:获取cell的唯一标识符
 */
+ (NSString *)cellReuseIdentifier;

/**
 *	功能:获取cell的高度
 *
 *	@param aData:cell的数据
 *  @param indexPath:cell位置
 *
 *	@return
 */
+ (CGFloat)heightForCellData:(id)aData atIndexPath:(NSIndexPath *)indexPath;

@end
