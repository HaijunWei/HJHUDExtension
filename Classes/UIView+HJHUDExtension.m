//
//  UIView+HJHUDExtension.m
//
//  Created by Haijun on 2019/5/16.
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
        self.loadingHUDCounter++;
    } else if (hud.mode == MBProgressHUDModeIndeterminate) {
        self.loadingHUDCounter++;
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
        self.loadingHUDCounter++;
    }
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.detailsLabel.text = text;
    hud.progress = progress;
    if (_configHUDBlock) { _configHUDBlock(hud); }
}

- (void)hideHUD {
    self.loadingHUDCounter--;
    if (self.loadingHUDCounter <= 0) {
        self.loadingHUDCounter = 0;
        [self.loadingHUD hideAnimated:YES];
        self.loadingHUD = nil;
    }
}

- (void)showHUDText:(NSString *)text {
    [self showHUDText:text second:2];
}

- (void)showHUDText:(NSString *)text second:(NSInteger)second {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    [hud hideAnimated:YES afterDelay:second];
    if (_configHUDBlock) { _configHUDBlock(hud); }
}

#pragma mark - Getter & Setter

static char kLoadingHUD;
static char kLoadingHUDCounter;

- (void)setLoadingHUD:(MBProgressHUD *)loadingHUD {
    objc_setAssociatedObject(self, &kLoadingHUD, loadingHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD *)loadingHUD {
    return objc_getAssociatedObject(self, &kLoadingHUD);
}

- (void)setLoadingHUDCounter:(NSInteger)loadingHUDCounter {
    objc_setAssociatedObject(self, &kLoadingHUDCounter, @(loadingHUDCounter), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)loadingHUDCounter {
    NSNumber *counter = objc_getAssociatedObject(self, &kLoadingHUDCounter);
    return counter ? counter.integerValue : 0;
}

@end
