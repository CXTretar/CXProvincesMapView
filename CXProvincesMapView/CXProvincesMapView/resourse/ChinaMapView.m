//
//  ChinaMapView.m
//  CXProvincesMapView
//
//  Created by Felix on 2019/5/19.
//  Copyright © 2019 CXTretar. All rights reserved.
//

#import "ChinaMapView.h"
#import "StyleKitName.h"

@implementation ChinaMapView

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)drawRect:(CGRect)rect {
    [StyleKitName drawCanvas2WithFrame:self.bounds resizing: StyleKitNameResizingBehaviorAspectFit];
}

@end
