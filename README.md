# CXProvincesMapView
![CXProvincesMapView](https://github.com/CXTretar/CXProvincesMapView/blob/master/gif/Oct-14-2019%2010-29-59.gif)
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
```
* CXProvincesMapViewDelegate【点击事件回调】
```
- (void)selectProvinceAtIndex:(NSInteger)index andName:(NSString *)name;
```
* example【示例】 
```
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
    NSLog(@"Province - %ld - %@", (long)index, name);
    self.title = [NSString stringWithFormat:@"Province - %ld - %@", (long)index, name];
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

```
