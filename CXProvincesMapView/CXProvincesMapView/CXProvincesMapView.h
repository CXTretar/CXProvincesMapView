//
//  CXProvincesMapView.h
//  CXProvincesMapView
//
//  Created by Felix on 2019/4/22.
//  Copyright © 2019 CXTretar. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ChinaMapPath.h"

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
@property(nonatomic, assign) CGFloat maximumZoomScale;     // default is 2.0

@property(nonatomic, strong) UIView *pinView;              // 图钉自定义视图
@property(nonatomic, strong) UIImage *pinImage;            // 图钉图片
@property(nonatomic, assign) BOOL pinAnimation;            // default is YES 图钉是否动画

@property(nonatomic, weak) id <CXProvincesMapViewDelegate>delegate;

/// 自定义的地图快捷创建方法
/// @param mapPath svg 绘图数据
/// @param mapSize svg 绘图尺寸
/// @param frame   视图控件的frame
- (instancetype)initWithMapPath:(ChinaMapPath *)mapPath andMapSize:(CGSize)mapSize andFrame:(CGRect)frame;

@end

