//
//  ViewController.m
//  Demo
//
//  Created by Haijun on 2019/5/16.
//  Copyright © 2019 Haijun. All rights reserved.
//

#import "ViewController.h"
#import "UIView+HJHUDExtension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD appearance].animationType = MBProgressHUDAnimationFade;
    [MBProgressHUD appearance].contentColor = [UIColor whiteColor];
    UIView.configHUDBlock = ^(MBProgressHUD * _Nonnull hud) {
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        if (hud.mode == MBProgressHUDModeText) {
            hud.offset = CGPointMake(0, 150);
        } else {
            hud.minSize = CGSizeMake(100, 100);
        }
    };
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.view showHUDLoading:@"Loading..."];
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.view showHUDLoading:@"加载中..."];
//    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view showHUDProgress:0.1 text:@"上传中..."];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view showHUDProgress:0.5 text:@"上传中..."];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view showHUDProgress:1 text:@"上传中..."];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view hideHUD];
    });
}


@end
