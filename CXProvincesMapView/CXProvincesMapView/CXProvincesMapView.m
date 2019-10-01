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

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) ChinaMapView *chinaMapView;

@end

@implementation CXProvincesMapView

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
   _chinaMapView.backgroundColor = backgroundColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        
    }
    
    return self;
}

- (void)setupUI {
    
    self.scrollview = [UIScrollView new];
   
    //设置实现缩放
    //设置代理scrollview的代理对象
    _scrollview.delegate = self;
    //设置最大伸缩比例
    _scrollview.maximumZoomScale = 2.0;
    //设置最小伸缩比例
    _scrollview.minimumZoomScale = 1.0;
    [_scrollview setZoomScale:1.0 animated:NO];

    
    [self addSubview:self.scrollview];
    self.chinaMapView = [ChinaMapView new];

    self.scrollview.frame = self.bounds;
    self.chinaMapView.frame = self.scrollview.bounds;
    [self.scrollview addSubview:self.chinaMapView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
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


@end
