

//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface YMButton : UIButton
typedef void(^ButtonBlock)(YMButton* button);
typedef void(^MasonryMakeButton)(MASConstraintMaker *make,YMButton* button);

/*默认限制连点*/
@property (assign,nonatomic) BOOL isSoonCliCKLimit;

//@property (nonatomic, copy)YMButton* (^buttonTitle)(NSString* title);
//
//@property (nonatomic, copy)YMButton* (^buttonTitleColor)(UIColor* color);

@property (nonatomic, copy)YMButton* (^buttonNormalTitle)(NSString* title);

@property (nonatomic, copy)YMButton* (^buttonSelectTitle)(NSString* title);

@property (nonatomic, copy)YMButton* (^buttonNormalTitleColor)(UIColor* color);

@property (nonatomic, copy)YMButton* (^buttonSelectTitleColor)(UIColor* color);

@property (nonatomic, copy)YMButton* (^buttonNormalImageName)(NSString* imageName);

@property (nonatomic, copy)YMButton* (^buttonSelectImageName)(NSString* imageName);

@property (nonatomic, copy)YMButton* (^buttonTitleFontSize)(CGFloat fontSize);

@property (nonatomic, copy)YMButton* (^buttonBackgroundColor)(UIColor* color);

@property (nonatomic, copy)YMButton* (^buttonSuperView)(UIView* view);

@property (nonatomic, copy)YMButton* with;

@property (nonatomic, copy)YMButton* (^buttonTag)(NSInteger tag);

@property (nonatomic, copy)ButtonBlock  buttonBlock;

@property (nonatomic, copy)YMButton* (^buttonLayer_BornerRadius)(CGFloat radius);

@property (nonatomic, copy)YMButton* (^buttonLayer_MaskToBounds)(BOOL isToBounds);

@property (nonatomic, copy)YMButton* (^buttonLayber_BorderWidth)(CGFloat width);

@property (nonatomic, copy)YMButton* (^buttonLayer_BorderColor)(UIColor* color);

//+(instancetype)butonInitWith:(void (^)(YMButton *))initBlock withSuperView:(UIView *)superView;

//+(instancetype)butonInitWith:(void(^)(YMButton* button))initBlock withSuperView:(UIView*)superView withButtonBlock:(ButtonBlock)buttonBlock;

+(instancetype)butonInitWith:(void (^)(YMButton *button))initBlock withSuperView:(UIView*)superView withMasonryMake:(MasonryMakeButton)masonryMake withButtonBlock:(ButtonBlock)buttonBlock ;


@end
