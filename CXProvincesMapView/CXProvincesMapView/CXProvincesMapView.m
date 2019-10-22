//
//  CXProvincesMapView.m
//  CXProvincesMapView
//
//  Created by Felix on 2019/4/22.
//  Copyright © 2019 CXTretar. All rights reserved.
//

#import "CXProvincesMapView.h"
#import "ChinaMapView.h"

@interface CXProvincesMapView()<UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *scrollview;
@property(nonatomic, strong) ChinaMapView *chinaMapView;

@end

@implementation CXProvincesMapView

- (void)setPinAnimation:(BOOL)pinAnimation {
    _pinAnimation = pinAnimation;
    self.chinaMapView.pinAnimation = pinAnimation;
}

- (void)setPinImage:(UIImage *)pinImage {
    _pinImage = pinImage;
    self.chinaMapView.pinImage.image = pinImage;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    _chinaMapView.backgroundColor = backgroundColor;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    _chinaMapView.selectedIndex = selectedIndex;
    [self selectProvinceAtIndex:selectedIndex andName:self.chinaMapView.mapPath.textArray[selectedIndex]];
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    _chinaMapView.fillColor = fillColor;
    [_chinaMapView setNeedsDisplay];
}

- (void)setFillSelectedColor:(UIColor *)fillSelectedColor {
    _fillSelectedColor = fillSelectedColor;
    _chinaMapView.fillSelectedColor = fillSelectedColor;
    [_chinaMapView setNeedsDisplay];
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    _chinaMapView.strokeColor = strokeColor;
    [_chinaMapView setNeedsDisplay];
}

- (void)setStrokeSelectedColor:(UIColor *)strokeSelectedColor {
    _strokeColor = strokeSelectedColor;
    _chinaMapView.strokeSelectedColor = strokeSelectedColor;
    [_chinaMapView setNeedsDisplay];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _chinaMapView.textColor = textColor;
    [_chinaMapView setNeedsDisplay];
}

- (void)setTextSelectedColor:(UIColor *)textSelectedColor {
    _textSelectedColor = textSelectedColor;
    _chinaMapView.textSelectedColor = textSelectedColor;
    [_chinaMapView setNeedsDisplay];
}

- (void)setMaximumZoomScale:(CGFloat)maximumZoomScale {
    _maximumZoomScale = maximumZoomScale;
    self.scrollview.maximumZoomScale = maximumZoomScale;
}

- (void)setMinimumZoomScale:(CGFloat)minimumZoomScale {
    _minimumZoomScale = minimumZoomScale;
    self.scrollview.minimumZoomScale = minimumZoomScale;
}


- (instancetype)initWithMapPath:(ChinaMapPath *)mapPath andMapSize:(CGSize)mapSize andFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 检查 mapPath 格式
        if (mapPath.textArray.count < mapPath.textRectArray.count) {
            NSLog(@"textArray 与 textRectArray 数目不符");
            NSMutableArray *tempArray = mapPath.textArray.mutableCopy;
            for (int i = 0; i < mapPath.textRectArray.count - mapPath.textArray.count; i++) {
                [tempArray addObject:@""];
            }
            mapPath.textArray = tempArray.copy;
        }
        [self setupUI];
        self.chinaMapView.mapWidth = 308;
        self.chinaMapView.mapHeight = 340;
        self.chinaMapView.mapPath = mapPath;
        self.chinaMapView.frame = self.scrollview.bounds;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.chinaMapView.frame = self.scrollview.bounds;
    }
    
    return self;
}

- (void)setupUI {
    
    self.scrollview = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.showsHorizontalScrollIndicator = NO;
    //设置实现缩放
    //设置代理scrollview的代理对象
    _scrollview.delegate = self;
    //设置最大伸缩比例
    _scrollview.maximumZoomScale = 10.0;
    //设置最小伸缩比例
    _scrollview.minimumZoomScale = 1.0;
    [_scrollview setZoomScale:1.0 animated:NO];
    [self addSubview: _scrollview];
    
    self.chinaMapView = [[ChinaMapView alloc] init];
    typeof(self) __weak weakSelf = self;
    self.chinaMapView.block = ^(NSInteger index, NSString *name) {
        weakSelf.selectedIndex = index;
    };
    [_scrollview addSubview: _chinaMapView];
    self.pinImage = self.chinaMapView.pinImage.image;
    self.pinView = self.chinaMapView.pinView;
    
    
}

- (void)setFrame:(CGRect)frame {
    self.scrollview.frame = self.bounds;
    self.chinaMapView.frame = self.scrollview.bounds;
    [_scrollview setZoomScale:1.0 animated:NO];
    [super setFrame:frame];
}

// 告诉scrollview要缩放的是哪个子控件
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _chinaMapView;
}

// 这个方法是针对scrollView在缩小时无法居中的问题，scrollView放大，只要在设置完zoomScale之后设置偏移量为(0,0)即可实现放大居中
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentInset.left - scrollView.contentInset.right - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentInset.top - scrollView.contentInset.bottom - scrollView.contentSize.height) * 0.5, 0.0);
    
    self.chinaMapView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                           scrollView.contentSize.height * 0.5 + offsetY);
    
}

#pragma mark - CXProvincesMapViewDelegate

- (void)selectProvinceAtIndex:(NSInteger)index andName:(NSString *)name {
    if ([self.delegate respondsToSelector:@selector(selectProvinceAtIndex:andName:)]) {
        [self.delegate selectProvinceAtIndex:index andName:name];
    }
}


@end
