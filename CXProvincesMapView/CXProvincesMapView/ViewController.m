//
//  ViewController.m
//  CXProvincesMapView
//
//  Created by Felix on 2019/4/15.
//  Copyright © 2019 CXTretar. All rights reserved.
//

#import "ViewController.h"
#import "SwiftLaunchView.h"

@interface ViewController ()

@property(nonatomic, strong) SwiftLaunchView *launchView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self launchAnimation];
    
}

- (void)launchAnimation
{
    //获取到LaunchScreen控制器(不要忘记id)
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    
    //获取LaunchScreen的view
    UIView *launchView = viewController.view;
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    launchView.frame = [UIApplication sharedApplication].keyWindow.frame;
    [mainWindow addSubview:launchView];
    
    //添加launchView类
    self.launchView = [[SwiftLaunchView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.launchView addLayerToLaunchView];
    [launchView addSubview:self.launchView];
    
    //最后移除
    [UIView animateWithDuration:0.5f delay:2.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        launchView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
    }];
}

@end
