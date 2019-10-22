//
//  FujianMapController.m
//  CXProvincesMapView
//
//  Created by CXTretar on 2019/10/22.
//  Copyright © 2019 CXTretar. All rights reserved.
//

#import "FujianMapController.h"
#import "CXProvincesMapView.h"
#import "FujianMapPath.h"

@interface FujianMapController ()<CXProvincesMapViewDelegate>

@property (nonatomic, strong) CXProvincesMapView *chinaMapView;

@end

@implementation FujianMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 福建省市数据
    FujianMapPath *mapPath = [[FujianMapPath alloc] init];
    self.chinaMapView = [[CXProvincesMapView alloc]initWithMapPath:mapPath andMapSize:CGSizeMake(308, 340) andFrame:CGRectMake(0, 0, self.view.bounds.size.width, 400)];
    _chinaMapView.backgroundColor = [UIColor colorWithRed:230/255.0 green:1.0 blue:1.0 alpha:1.0];
    _chinaMapView.maximumZoomScale = 5.0;
    _chinaMapView.center = self.view.center;
    _chinaMapView.delegate = self;
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
    NSLog(@"福建省 - %ld - %@", (long)index, name);
    self.title = [NSString stringWithFormat:@"福建省 - %ld - %@", (long)index, name];
}

- (void)pinTest {
    NSLog(@"%s", __func__);
}


@end
