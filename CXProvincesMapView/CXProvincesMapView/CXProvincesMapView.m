//
//  CXProvincesMapView.m
//  CXProvincesMapView
//
//  Created by Felix on 2019/4/22.
//  Copyright © 2019 CXTretar. All rights reserved.
//

#import "CXProvincesMapView.h"
#import "StyleKitName.h"

@implementation CXProvincesMapView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}


- (void)drawRect:(CGRect)rect {
    [StyleKitName drawCanvas2WithFrame:self.bounds resizing: StyleKitNameResizingBehaviorAspectFit];
    
}


@end
