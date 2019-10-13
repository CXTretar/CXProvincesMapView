//
//  ChinaMapView.m
//  CXProvincesMapView
//
//  Created by Felix on 2019/5/19.
//  Copyright © 2019 CXTretar. All rights reserved.
//

#import "ChinaMapView.h"
#import "ChinaMapPath.h"

#define MAP_SIZE_WIDTH  774
#define MAP_SIZE_HEIGHT 569
#define DEFAULT_FILL_COLOR              [UIColor colorWithRed: 0.8 green: 0.8 blue: 0.8 alpha: 1]
#define DEFAULT_FILL_SELECTED_COLOR     [UIColor colorWithRed: 0.7 green: 0.2 blue: 0.2 alpha: 1.0]
#define DEFAULT_STROKE_COLOR            [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
#define DEFAULT_STROKE_SELECTED_COLOR   [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];

@interface ChinaMapView ()

@property(nonatomic, strong) ChinaMapPath *mapPath;
@property(nonatomic, strong) NSMutableArray *pathColorArray;
@property(nonatomic, assign) NSInteger selectedIndex;

@end

@implementation ChinaMapView

- (void)setFillColor:(UIColor *)fillColor {

    _pathColorArray = [NSMutableArray arrayWithCapacity: self.mapPath.pathArray.count];
    for (int i = 0; i < _mapPath.pathArray.count; i++) {
        [_pathColorArray addObject:fillColor];
    }
    _fillColor = fillColor;
}

- (ChinaMapPath *)mapPath {
    if (!_mapPath) {
        _mapPath = [[ChinaMapPath alloc] init];
    }
    return _mapPath;
}

- (instancetype)init {
    if (self = [super init]) {
        self.fillColor = DEFAULT_FILL_COLOR;
        self.fillSelectedColor = DEFAULT_FILL_SELECTED_COLOR;
        self.strokeColor = DEFAULT_STROKE_COLOR;
        self.selectedIndex = 0;
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:click];
    }
    
    return self;
}

- (void)click:(UITapGestureRecognizer *)sender {

    CGPoint point = [sender locationInView:sender.view];
    CGRect resizedFrame = [self resizing:CGRectMake(0, 0, MAP_SIZE_WIDTH, MAP_SIZE_HEIGHT) target:self.bounds];
    point = CGPointMake((point.x - resizedFrame.origin.x) * MAP_SIZE_WIDTH / resizedFrame.size.width, (point.y - resizedFrame.origin.y) * MAP_SIZE_HEIGHT /resizedFrame.size.height );
    
    for (int i = 0; i < self.mapPath.pathArray.count; i++) {
        UIBezierPath *path = self.mapPath.pathArray[i];
        
        if ([path containsPoint:point]) {
            //清除之前选中的颜色，fill当前选中的颜色
            self.pathColorArray[_selectedIndex] = self.fillColor;
            _selectedIndex = i;
            self.pathColorArray[i] = self.fillSelectedColor;
            
            [self setNeedsDisplay];
            
            break;
        }
    }
    
}

- (void)drawRect:(CGRect)rect {
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = [self resizing:CGRectMake(0, 0, MAP_SIZE_WIDTH, MAP_SIZE_HEIGHT) target: self.bounds];
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / MAP_SIZE_WIDTH, resizedFrame.size.height / MAP_SIZE_HEIGHT);
    
    UIColor* strokeColor = self.strokeColor;

    [self.mapPath.pathArray enumerateObjectsUsingBlock:^(UIBezierPath *path, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.pathColorArray[idx] setFill];
        [path fill];
        [strokeColor setStroke];
        path.lineWidth = 0.5;
        path.miterLimit = 4;
        [path stroke];
        
    }];
    
    
    for (int i = 0; i < self.mapPath.textRectArray.count; i++) {
        CGRect textRect = [self.mapPath.textRectArray[i] CGRectValue];
        NSString *textContent = self.mapPath.textArray[i];
        
        NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
        textStyle.alignment = NSTextAlignmentLeft;
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 11], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
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
