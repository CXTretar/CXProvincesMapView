# CXProvincesMapView
![CXProvincesMapView](https://github.com/CXTretar/CXProvincesMapView/blob/master/gif/province.gif)

### 关于自定义 MapPath 的数据获取可以看下这里 [使用 PaintCode 绘制自定义的省份地图控件](https://cxtretar.github.io/2019/10/27/使用-PaintCode-绘制自定义的省份地图控件/)

# Update【更新】
- 10.17 新增了图钉点击效果，可以添加自定义视图 
- 10.22 增加了新的构造方法，提供外部传入 mapPath 参数， 修复了PinView的大小计算Bug，Demo增加了福建省的数据以及视图 

# Install【安装】
在Podfile文件中添加`pod 'CXProvincesMapView'`，并运行 `pod install`
# Usage【使用】
* import【导入框架】
`#import "CXProvincesMapView.h"`

* custom【自定义属性】
```
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
```
* example【示例】 
```
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


```
* 自定义的mapPath (mapPath 类继承 ChinaMapPath.h)【示例】 

```
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

```

