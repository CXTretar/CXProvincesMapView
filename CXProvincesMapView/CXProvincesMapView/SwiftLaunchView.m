//
//  SwiftLaunchView.m
//  CXProvincesMapView
//
//  Created by Felix on 2019/4/20.
//  Copyright © 2019 CXTretar. All rights reserved.
//

#import "SwiftLaunchView.h"

@interface SwiftLaunchView()

@property(nonatomic, strong) UIView *launchView;

@end

@implementation SwiftLaunchView

+ (void)launchAnimation {
    //获取到LaunchScreen控制器(不要忘记id)
    UIViewController *launchScreenController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    
    //获取LaunchScreen的view
    UIView *launchView = launchScreenController.view;
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    launchView.frame = [UIApplication sharedApplication].keyWindow.frame;
    [mainWindow addSubview:launchView];
    
    //添加launchView类
    SwiftLaunchView *swiftLaunchView = [[SwiftLaunchView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [launchView addSubview:swiftLaunchView];
    //最后移除
    [UIView animateWithDuration:0.5f delay:2.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        launchView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
    }];
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addLayerToLaunchView];
    }
    return self;
}

- (void)addLayerToLaunchView {
    //添加launchView
    self.launchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.launchView.backgroundColor = [UIColor clearColor];
    self.launchView.center = self.center;
    [self addSubview:self.launchView];
    
    // 添加layer
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = [self swiftBezierPath].CGPath;
    layer.bounds = CGPathGetBoundingBox(layer.path);
    self.backgroundColor = [UIColor colorWithRed:247/255.0 green:147/255.0 blue:55/255.0 alpha:1.0];
    layer.position = CGPointMake(self.launchView.bounds.size.width / 2, self.launchView.bounds.size.height/ 2);
    layer.fillColor = [UIColor whiteColor].CGColor;
    [self.launchView.layer addSublayer:layer];
    
    //执行动画
    [self performSelector:@selector(startLaunch) withObject:nil afterDelay:1.0];
}

- (void)startLaunch {
    [UIView animateWithDuration:1 animations:^{
        //先缩小launchView
        self.launchView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            
            //在无线放大launchView
            self.launchView.transform = CGAffineTransformMakeScale(50, 50);
            self.launchView.alpha = 0;
        } completion:^(BOOL finished) {
            
            //最后移除
            [self.launchView removeFromSuperview];
            [self removeFromSuperview];
        }];;
    }];
}

// PaintCode 绘制的swift
- (UIBezierPath *)swiftBezierPath {
    UIColor* strokeColor = [UIColor colorWithRed: 0.592 green: 0.592 blue: 0.592 alpha: 1];
    //// Path Drawing
    UIBezierPath* pathPath = [UIBezierPath bezierPath];
    [pathPath moveToPoint: CGPointMake(33.24, 187.6)];
    [pathPath addLineToPoint: CGPointMake(45.98, 199.12)];
    [pathPath addLineToPoint: CGPointMake(61.06, 212.05)];
    [pathPath addLineToPoint: CGPointMake(84.51, 230.28)];
    [pathPath addLineToPoint: CGPointMake(96.33, 239.24)];
    [pathPath addLineToPoint: CGPointMake(105.6, 245.76)];
    [pathPath addLineToPoint: CGPointMake(107.78, 238.82)];
    [pathPath addLineToPoint: CGPointMake(108.9, 232.53)];
    [pathPath addLineToPoint: CGPointMake(109.77, 225.01)];
    [pathPath addLineToPoint: CGPointMake(109.44, 217.6)];
    [pathPath addLineToPoint: CGPointMake(108.66, 210.98)];
    [pathPath addLineToPoint: CGPointMake(107.06, 203.96)];
    [pathPath addLineToPoint: CGPointMake(105.45, 199.44)];
    [pathPath addLineToPoint: CGPointMake(103.86, 194.59)];
    [pathPath addLineToPoint: CGPointMake(101.64, 189.87)];
    [pathPath addLineToPoint: CGPointMake(98.56, 183.6)];
    [pathPath addLineToPoint: CGPointMake(96.98, 180.88)];
    [pathPath addLineToPoint: CGPointMake(94.58, 176.31)];
    [pathPath addLineToPoint: CGPointMake(92.99, 174)];
    [pathPath addLineToPoint: CGPointMake(101.56, 180.44)];
    [pathPath addLineToPoint: CGPointMake(107.22, 185.31)];
    [pathPath addLineToPoint: CGPointMake(118.36, 195.86)];
    [pathPath addLineToPoint: CGPointMake(128.55, 209.57)];
    [pathPath addLineToPoint: CGPointMake(134.08, 220.04)];
    [pathPath addLineToPoint: CGPointMake(137.67, 230.03)];
    [pathPath addLineToPoint: CGPointMake(139.31, 239.28)];
    [pathPath addLineToPoint: CGPointMake(140.32, 248.41)];
    [pathPath addLineToPoint: CGPointMake(139.74, 256.97)];
    [pathPath addLineToPoint: CGPointMake(137.21, 267.21)];
    [pathPath addLineToPoint: CGPointMake(138.15, 269.79)];
    [pathPath addLineToPoint: CGPointMake(141.7, 274.47)];
    [pathPath addLineToPoint: CGPointMake(145.3, 280.74)];
    [pathPath addLineToPoint: CGPointMake(148.58, 288.67)];
    [pathPath addLineToPoint: CGPointMake(150, 296.99)];
    [pathPath addLineToPoint: CGPointMake(149.5, 303.95)];
    [pathPath addLineToPoint: CGPointMake(148.39, 306.84)];
    [pathPath addLineToPoint: CGPointMake(146.55, 305.89)];
    [pathPath addLineToPoint: CGPointMake(143.02, 301.51)];
    [pathPath addLineToPoint: CGPointMake(138.58, 298.13)];
    [pathPath addLineToPoint: CGPointMake(134.64, 296.23)];
    [pathPath addLineToPoint: CGPointMake(129.48, 294.8)];
    [pathPath addLineToPoint: CGPointMake(124.78, 294.81)];
    [pathPath addLineToPoint: CGPointMake(120.29, 295.69)];
    [pathPath addLineToPoint: CGPointMake(115.38, 298.15)];
    [pathPath addLineToPoint: CGPointMake(108.58, 301.74)];
    [pathPath addLineToPoint: CGPointMake(97.17, 305.98)];
    [pathPath addLineToPoint: CGPointMake(89.95, 307.29)];
    [pathPath addLineToPoint: CGPointMake(80.86, 307.58)];
    [pathPath addLineToPoint: CGPointMake(72.62, 306.93)];
    [pathPath addLineToPoint: CGPointMake(59.21, 304.66)];
    [pathPath addLineToPoint: CGPointMake(47.38, 301.09)];
    [pathPath addLineToPoint: CGPointMake(37.51, 296.56)];
    [pathPath addLineToPoint: CGPointMake(28.33, 290.85)];
    [pathPath addLineToPoint: CGPointMake(21.41, 285.76)];
    [pathPath addLineToPoint: CGPointMake(14.58, 279.8)];
    [pathPath addLineToPoint: CGPointMake(7.98, 272.26)];
    [pathPath addLineToPoint: CGPointMake(2.44, 265.23)];
    [pathPath addLineToPoint: CGPointMake(0, 261.01)];
    [pathPath addLineToPoint: CGPointMake(5.32, 264.54)];
    [pathPath addLineToPoint: CGPointMake(13.39, 268.86)];
    [pathPath addLineToPoint: CGPointMake(23.49, 272.5)];
    [pathPath addLineToPoint: CGPointMake(34.16, 276.23)];
    [pathPath addLineToPoint: CGPointMake(42.89, 277.81)];
    [pathPath addLineToPoint: CGPointMake(52.34, 278.79)];
    [pathPath addLineToPoint: CGPointMake(62.37, 278.15)];
    [pathPath addLineToPoint: CGPointMake(69.9, 276.34)];
    [pathPath addLineToPoint: CGPointMake(75.19, 275.03)];
    [pathPath addLineToPoint: CGPointMake(84.54, 270.85)];
    [pathPath addLineToPoint: CGPointMake(75.45, 263.98)];
    [pathPath addLineToPoint: CGPointMake(66.72, 256.2)];
    [pathPath addLineToPoint: CGPointMake(54.02, 243.02)];
    [pathPath addLineToPoint: CGPointMake(45.69, 232.94)];
    [pathPath addLineToPoint: CGPointMake(29.86, 214.82)];
    [pathPath addLineToPoint: CGPointMake(14.33, 194.69)];
    [pathPath addLineToPoint: CGPointMake(43.52, 218.64)];
    [pathPath addLineToPoint: CGPointMake(68.3, 236.21)];
    [pathPath addLineToPoint: CGPointMake(73.55, 239.15)];
    [pathPath addLineToPoint: CGPointMake(67.31, 233.13)];
    [pathPath addLineToPoint: CGPointMake(59.18, 223)];
    [pathPath addLineToPoint: CGPointMake(52.13, 214.22)];
    [pathPath addLineToPoint: CGPointMake(43.06, 201.52)];
    [pathPath addLineToPoint: CGPointMake(33.24, 187.6)];
    [pathPath closePath];
    [strokeColor setStroke];
    pathPath.lineWidth = 1;
    pathPath.miterLimit = 4;
    return pathPath;
}

@end
