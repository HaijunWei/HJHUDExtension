//
//  UIView+HJHUDExtension.h
//
//  Created by Haijun on 2019/5/16.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^HJConfigHUDBlock)(MBProgressHUD *hud);

@interface UIView (HJHUDExtension)

/// 统一配置HUD样式
@property (nonatomic, strong, class) HJConfigHUDBlock configHUDBlock;

/**
 显示Loading样式HUD
 */
- (void)showHUDLoading;

/**
 显示Loading样式HUD

 @param text 提示文本
 */
- (void)showHUDLoading:(NSString *_Nullable)text;

/**
 显示Progress样式HUD

 @param progress 进度
 */
- (void)showHUDProgress:(float)progress;

/**
 显示Progress样式HUD

 @param progress 进度
 @param text 提示文本
 */
- (void)showHUDProgress:(float)progress text:(NSString *_Nullable)text;

/**
 隐藏Loading/ProgressHUD
 */
- (void)hideHUD;


/**
 显示纯文本HUD，2s后隐藏

 @param text 提示文本
 */
- (void)showHUDText:(NSString *)text;

/**
 显示纯文本HUD

 @param text 提示文本
 @param second 显示时长
 */
- (void)showHUDText:(NSString *)text second:(NSInteger)second;

@end

NS_ASSUME_NONNULL_END
