//
//  UIView+HJHUDExtension.m
//  Demo
//
//  Created by Haijun on 2019/5/16.
//  Copyright © 2019 Haijun. All rights reserved.
//

#import "UIView+HJHUDExtension.h"
#import <objc/runtime.h>

@implementation UIView (HJHUDExtension)

#pragma mark - Class Property

static HJConfigHUDBlock _configHUDBlock = nil;

+ (void)setConfigHUDBlock:(HJConfigHUDBlock)configHUDBlock {
    _configHUDBlock = configHUDBlock;
}

+ (HJConfigHUDBlock)configHUDBlock {
    return _configHUDBlock;
}

#pragma mark - Public

- (void)showHUDLoading {
    [self showHUDLoading:nil];
}

- (void)showHUDLoading:(NSString *)text {
    MBProgressHUD *hud = self.loadingHUD;
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        self.loadingHUD = hud;
    }
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabel.text = text;
    if (_configHUDBlock) { _configHUDBlock(hud); }
}

- (void)showHUDProgress:(float)progress {
    [self showHUDProgress:progress text:nil];
}

- (void)showHUDProgress:(float)progress text:(NSString *)text {
    MBProgressHUD *hud = self.loadingHUD;
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        self.loadingHUD = hud;
    }
    hud.mode = MBProgressHUDModeDeterminate;
    hud.detailsLabel.text = text;
    hud.progress = progress;
    if (_configHUDBlock) { _configHUDBlock(hud); }
}

- (void)hideHUD {
    [self.loadingHUD hideAnimated:YES];
    self.loadingHUD = nil;
}

- (void)showHUDText:(NSString *)text {
    [self showHUDText:text second:2];
}

- (void)showHUDText:(NSString *)text second:(NSInteger)second {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    [hud hideAnimated:YES afterDelay:second];
    if (_configHUDBlock) { _configHUDBlock(hud); }
}

#pragma mark - Getter & Setter

static char kLoadingHUD;

- (void)setLoadingHUD:(MBProgressHUD *)loadingHUD {
    objc_setAssociatedObject(self, &kLoadingHUD, loadingHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD *)loadingHUD {
    return objc_getAssociatedObject(self, &kLoadingHUD);
}

@end
