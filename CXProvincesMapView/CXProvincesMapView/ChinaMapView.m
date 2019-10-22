//
//  ChinaMapView.m
//  CXProvincesMapView
//
//  Created by Felix on 2019/5/19.
//  Copyright © 2019 CXTretar. All rights reserved.
//

#import "ChinaMapView.h"

#define MAP_SIZE_WIDTH  774
#define MAP_SIZE_HEIGHT 569
#define DEFAULT_FILL_COLOR              [UIColor colorWithRed: 0.8 green: 0.8 blue: 0.8 alpha: 1]
#define DEFAULT_FILL_SELECTED_COLOR     [UIColor colorWithRed: 0.4 green: 0.3 blue: 0.8 alpha: 1]
#define DEFAULT_STROKE_COLOR            [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1]
#define DEFAULT_STROKE_SELECTED_COLOR   [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1]
#define DEFAULT_TEXT_COLOR              [UIColor blackColor]
#define DEFAULT_TEXT_SELECTED_COLOR     [UIColor redColor]

@interface ChinaMapView ()

@property(nonatomic, strong) NSMutableArray *pathColorArray;
@property(nonatomic, strong) NSMutableArray *strokeColorArray;
@property(nonatomic, strong) NSMutableArray *textColorArray;

@end

@implementation ChinaMapView

- (void)setMapPath:(ChinaMapPath *)mapPath {
    _mapPath = mapPath;
    [self setNeedsDisplay];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self setNeedsDisplay];
    [self showPinViewWithAnimation:_pinAnimation];
}

- (void)setFillColor:(UIColor *)fillColor {
    _pathColorArray = [NSMutableArray arrayWithCapacity: self.mapPath.pathArray.count];
    for (int i = 0; i < _mapPath.pathArray.count; i++) {
        [_pathColorArray addObject:fillColor];
    }
    _fillColor = fillColor;
}

- (void)setFillSelectedColor:(UIColor *)fillSelectedColor {
    _fillSelectedColor = fillSelectedColor;
    if (_selectedIndex >= 0) {
        _pathColorArray[_selectedIndex] = _fillSelectedColor;
    }
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColorArray = [NSMutableArray arrayWithCapacity: self.mapPath.pathArray.count];
    for (int i = 0; i < _mapPath.pathArray.count; i++) {
        [_strokeColorArray addObject:strokeColor];
    }
    _strokeColor = strokeColor;
}

- (void)setStrokeSelectedColor:(UIColor *)strokeSelectedColor {
    _strokeSelectedColor = strokeSelectedColor;
    if (_selectedIndex >= 0)  {
        _strokeColorArray[_selectedIndex] = _strokeSelectedColor;
    }
}

- (void)setTextColor:(UIColor *)textColor {
    _textColorArray = [NSMutableArray arrayWithCapacity: self.mapPath.pathArray.count];
    for (int i = 0; i < _mapPath.pathArray.count; i++) {
        [_textColorArray addObject:textColor];
    }
    _textColor = textColor;
}

- (void)setTextSelectedColor:(UIColor *)textSelectedColor {
    _textSelectedColor = textSelectedColor;
    if (_selectedIndex >= 0)  {
        _textColorArray[_selectedIndex] = _textSelectedColor;
    }
}

- (instancetype)init {
    if (self = [super init]) {
        self.mapPath = [[ChinaMapPath alloc] init];
        self.mapWidth = MAP_SIZE_WIDTH;
        self.mapHeight = MAP_SIZE_HEIGHT;
        self.selectedIndex = -1;
        self.fillColor = DEFAULT_FILL_COLOR;
        self.fillSelectedColor = DEFAULT_FILL_SELECTED_COLOR;
        self.strokeColor = DEFAULT_STROKE_COLOR;
        self.strokeSelectedColor = DEFAULT_STROKE_SELECTED_COLOR;
        self.textColor = DEFAULT_TEXT_COLOR;
        self.textSelectedColor = DEFAULT_TEXT_SELECTED_COLOR;
        self.pinAnimation = YES;
        self.pinView = [UIView new];
        self.pinImage = [UIImageView new];
        [self.pinView addSubview:self.pinImage];
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:click];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
    [self showPinViewWithAnimation:NO];
    if (_selectedIndex < 0) {
        CGRect resizedFrame = [self resizing:CGRectMake(0, 0, _mapWidth, _mapHeight) target:frame];
        CGFloat width = 20 * resizedFrame.size.width / _mapWidth;
        CGFloat height = 20 * resizedFrame.size.height / _mapHeight;
        self.pinView.frame = CGRectMake(0,  0, width, height);
    }
    
}

- (void)showPinViewWithAnimation:(BOOL)isAnimation {
    if (_selectedIndex < 0) return;
    
    CGPoint pinPoint = CGPointFromString(self.mapPath.pinPointArray[_selectedIndex]);
    CGRect resizedFrame = [self resizing:CGRectMake(0, 0, _mapWidth, _mapHeight) target:self.bounds];
    CGFloat x = resizedFrame.origin.x + pinPoint.x  * resizedFrame.size.width / _mapWidth;
    CGFloat y = resizedFrame.origin.y + pinPoint.y  * resizedFrame.size.height / _mapHeight;
    CGFloat width = 20 * resizedFrame.size.width / _mapWidth;
    CGFloat height = 20 * resizedFrame.size.height / _mapHeight;
    
    self.pinView.frame = CGRectMake(x,  y, width, height);
    self.pinImage.frame = self.pinView.bounds;
    [self addSubview:self.pinView];
    
    if (isAnimation) {
        CGPoint center = self.pinView.center;
        CGFloat change = 10 * resizedFrame.size.height / _mapHeight;
        self.pinView.center = CGPointMake(center.x, center.y - change);
        [UIView animateWithDuration:0.2 animations:^{
            self.pinView.center = CGPointMake(center.x, center.y);
        }];
    }
}


- (void)click:(UITapGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:sender.view];
    
    CGRect resizedFrame = [self resizing:CGRectMake(0, 0, _mapWidth, _mapHeight) target:self.bounds];
    point = CGPointMake((point.x - resizedFrame.origin.x) * _mapWidth / resizedFrame.size.width, (point.y - resizedFrame.origin.y) * _mapHeight /resizedFrame.size.height);
    
    for (int i = 0; i < self.mapPath.pathArray.count; i++) {
        UIBezierPath *path = self.mapPath.pathArray[i];
        
        if ([path containsPoint:point]) {
            
            //清除之前选中的颜色，fill当前选中的颜色
            if (_selectedIndex >= 0) {
                self.pathColorArray[_selectedIndex] = self.fillColor;
                self.strokeColorArray[_selectedIndex] = self.strokeColor;
                self.textColorArray[_selectedIndex] = self.textColor;
            }
            
            self.selectedIndex = i;
            self.pathColorArray[i] = self.fillSelectedColor;
            self.strokeColorArray[i] = self.strokeSelectedColor;
            self.textColorArray[i] = self.textSelectedColor;
            if (_selectedIndex != i) {
                [self setNeedsDisplay];
            }
            [self showPinViewWithAnimation:_pinAnimation];
            if (self.block) {
                self.block(i, self.mapPath.textArray[i]);
            }
            break;
        }
    }
    
}

- (void)drawRect:(CGRect)rect {
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = [self resizing:CGRectMake(0, 0, _mapWidth, _mapHeight) target: self.bounds];
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / _mapWidth, resizedFrame.size.height / _mapHeight);
    
    [self.mapPath.pathArray enumerateObjectsUsingBlock:^(UIBezierPath *path, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.pathColorArray[idx] setFill];
        [path fill];
        [self.strokeColorArray[idx] setStroke];
        path.lineWidth = 0.5;
        path.miterLimit = 4;
        
        [path stroke];
        
    }];
    
    
    for (int i = 0; i < self.mapPath.textRectArray.count; i++) {
        CGRect textRect = [self.mapPath.textRectArray[i] CGRectValue];
        NSString *textContent = self.mapPath.textArray[i];
        NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
        textStyle.alignment = NSTextAlignmentLeft;
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 11], NSForegroundColorAttributeName: self.textColorArray[i], NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, textRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (textRect.size.height - textTextHeight) / 2, textRect.size.width, textTextHeight) withAttributes: textFontAttributes];
        CGContextRestoreGState(context);
    }
}

- (CGRect)resizing:(CGRect)rect target:(CGRect)target {
    if (CGRectEqualToRect(rect, target) || CGRectEqualToRect(target, CGRectZero))
        return rect;
    
    CGSize scales = CGSizeZero;
    scales.width = ABS(target.size.width / rect.size.width);
    scales.height = ABS(target.size.height / rect.size.height);
    
    scales.width = MIN(scales.width, scales.height);
    scales.height = scales.width;
    
    CGRect result = CGRectStandardize(rect);
    result.size.width *= scales.width;
    result.size.height *= scales.height;
    result.origin.x = target.origin.x + (target.size.width - result.size.width) / 2;
    result.origin.y = target.origin.y + (target.size.height - result.size.height) / 2;
    return result;
}



@end
