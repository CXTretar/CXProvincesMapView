//
//  SampleMapController.m
//  CXProvincesMapView
//
//  Created by Felix on 2019/4/22.
//  Copyright © 2019 CXTretar. All rights reserved.
//

#import "SampleMapController.h"
#import "CXProvincesMapView.h"

@interface SampleMapController ()<CXProvincesMapViewDelegate>

@property (nonatomic, strong) CXProvincesMapView *chinaMapView;

@end

@implementation SampleMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SampleMapController";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.chinaMapView = [[CXProvincesMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 400)];
    _chinaMapView.backgroundColor = [UIColor colorWithRed:230/255.0 green:1.0 blue:1.0 alpha:1.0];
    _chinaMapView.maximumZoomScale = 5.0;
    _chinaMapView.delegate = self;
    _chinaMapView.center = self.view.center;
//    _chinaMapView.pinAnimation = NO;
    // 直接设置图片
//    _chinaMapView.pinImage = [UIImage imageNamed:@"pin"];
    // 添加按钮点击
    UIButton *pinButton = [[UIButton alloc]initWithFrame:_chinaMapView.pinView.bounds];
    [pinButton setImage:[UIImage imageNamed:@"pin"] forState:UIControlStateNormal];
    [pinButton addTarget:self action:@selector(pinTest) forControlEvents:UIControlEventTouchUpInside];
    [_chinaMapView.pinView addSubview:pinButton];
    
    [self.view addSubview:_chinaMapView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //
    if (self.view.bounds.size.width > self.view.bounds.size.height) {
        self.chinaMapView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 400);
    } else {
        self.chinaMapView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 400);
    }
    self.chinaMapView.center = self.view.center;
}

- (void)selectProvinceAtIndex:(NSInteger)index andName:(NSString *)name {
    NSLog(@"Province - %ld - %@", (long)index, name);
    self.title = [NSString stringWithFormat:@"Province - %ld - %@", (long)index, name];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _chinaMapView.selectedIndex = 0;
    _chinaMapView.fillColor = [UIColor cyanColor];
    _chinaMapView.fillSelectedColor = [UIColor greenColor];
    _chinaMapView.strokeColor = [UIColor whiteColor];
    _chinaMapView.strokeSelectedColor = [UIColor greenColor];
    _chinaMapView.textColor = [UIColor blueColor];
    _chinaMapView.textSelectedColor = [UIColor orangeColor];
    
}

- (void)pinTest {
    NSLog(@"%s", __func__);
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
