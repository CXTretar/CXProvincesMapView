//
//  ViewController.m
//  CXProvincesMapView
//
//  Created by Felix on 2019/4/15.
//  Copyright © 2019 CXTretar. All rights reserved.
//

#import "ViewController.h"
#import "SwiftLaunchView.h"
#import "SampleMapController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [SwiftLaunchView launchAnimation];
    // Do any additional setup after loading the view.
}

- (IBAction)mapClick:(id)sender {
    
    [self.navigationController pushViewController:[SampleMapController new] animated:YES];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}


@end
