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
    
    self.chinaMapView = [[CXProvincesMapView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 400)];
    _chinaMapView.backgroundColor = [UIColor colorWithRed:230/255.0 green:1.0 blue:1.0 alpha:1.0];
    _chinaMapView.maximumZoomScale = 5.0;
    _chinaMapView.delegate = self;

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
    NSLog(@"Province - %ld - %@", index, name);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _chinaMapView.selectedIndex = 10;
    _chinaMapView.fillColor = [UIColor cyanColor];
    _chinaMapView.fillSelectedColor = [UIColor greenColor];
    _chinaMapView.strokeColor = [UIColor whiteColor];
    _chinaMapView.strokeSelectedColor = [UIColor greenColor];
    _chinaMapView.textColor = [UIColor blueColor];
    _chinaMapView.textSelectedColor = [UIColor orangeColor];
    
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
