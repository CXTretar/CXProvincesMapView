//
//  ChinaMapView.h
//  CXProvincesMapView
//
//  Created by Felix on 2019/5/19.
//  Copyright © 2019 CXTretar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChinaMapPath.h"

typedef void (^ChinaMapViewSelectBlock)(NSInteger index, NSString *name);

@interface ChinaMapView : UIView

@property(nonatomic, strong) ChinaMapPath *mapPath;
@property(nonatomic, copy) ChinaMapViewSelectBlock block;
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, strong) UIColor *fillColor;
@property(nonatomic, strong) UIColor *fillSelectedColor;
@property(nonatomic, strong) UIColor *strokeColor;
@property(nonatomic, strong) UIColor *strokeSelectedColor;
@property(nonatomic, strong) UIColor *textColor;
@property(nonatomic, strong) UIColor *textSelectedColor;

@property(nonatomic, assign) CGFloat mapWidth;
@property(nonatomic, assign) CGFloat mapHeight;

@property(nonatomic, strong) UIView *pinView;
@property(nonatomic, strong) UIImageView *pinImage;
@property(nonatomic, assign) BOOL pinAnimation;

@end

