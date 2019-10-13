//
//  CXProvincesMapView.h
//  CXProvincesMapView
//
//  Created by Felix on 2019/4/22.
//  Copyright © 2019 CXTretar. All rights reserved.
//


#import <UIKit/UIKit.h>

/*
默认省份顺序
@[
    @"黑龙江省",  @"吉林省", @"辽宁省", @"北京市", @"天津市",
    @"河北省", @"山东省", @"江苏省", @"浙江省", @"上海市",
    @"福建省", @"台湾省", @"海南省", @"广东省", @"香港",
    @"澳门", @"广西壮族自治区", @"云南省", @"江西省", @"湖南省",
    @"贵州省", @"四川省", @"西藏自治区", @"新疆维吾尔自治区", @"青海省",
    @"甘肃省", @"内蒙古自治区", @"宁夏回族自治区", @"陕西省", @"山西省",
    @"河南省", @"安徽省", @"湖北省", @"重庆市",
];
*/

@protocol CXProvincesMapViewDelegate <NSObject>

- (void)selectProvinceAtIndex:(NSInteger)index andName:(NSString *)name;

@end

@interface CXProvincesMapView : UIView

@property(nonatomic, assign) NSInteger selectedIndex;      // 选中省份的index
@property(nonatomic, strong) UIColor *fillColor;           // 省份的背景颜色
@property(nonatomic, strong) UIColor *fillSelectedColor;   // 选中省份的背景颜色
@property(nonatomic, strong) UIColor *strokeColor;         // 省份边界的颜色
@property(nonatomic, strong) UIColor *strokeSelectedColor; // 选中省份边界的颜色
@property(nonatomic, strong) UIColor *textColor;           // 省份字体的颜色
@property(nonatomic, strong) UIColor *textSelectedColor;   // 选中省份字体的颜色

@property(nonatomic, assign) CGFloat minimumZoomScale;     // default is 1.0
@property(nonatomic, assign) CGFloat maximumZoomScale;     // default is 10.0

@property(nonatomic, weak) id <CXProvincesMapViewDelegate>delegate;

@end

