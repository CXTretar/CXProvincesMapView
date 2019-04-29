//
//  SampleMapController.m
//  CXProvincesMapView
//
//  Created by Felix on 2019/4/22.
//  Copyright © 2019 CXTretar. All rights reserved.
//

#import "SampleMapController.h"
#import "CXProvincesMapView.h"

@interface SampleMapController ()

@property (nonatomic, strong) CXProvincesMapView *chinaMapView;

@end

@implementation SampleMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SampleMapController";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CXProvincesMapView *mapView = [[CXProvincesMapView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width,self.view.bounds.size.width* 569 / 774)];
    mapView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:mapView];
}

@end
