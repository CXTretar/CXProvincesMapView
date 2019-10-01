//
//  ChinaMapView.m
//  CXProvincesMapView
//
//  Created by Felix on 2019/5/19.
//  Copyright © 2019 CXTretar. All rights reserved.
//

#import "ChinaMapView.h"
#import "ChinaMapPath.h"

@interface ChinaMapView ()

@property(nonatomic, strong) ChinaMapPath *mapPath;

@end

@implementation ChinaMapView

- (ChinaMapPath *)mapPath {
    if (!_mapPath) {
        _mapPath = [[ChinaMapPath alloc] init];
    }
    return _mapPath;
}

- (instancetype)init {
    if (self = [super init]) {
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        
        [self addGestureRecognizer:click];
    }
    
    return self;
}

- (void)click:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:sender.view];
    NSLog(@"%@", NSStringFromCGPoint(point));
    [self setNeedsDisplay];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)drawRect:(CGRect)rect {
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = [self resizing:CGRectMake(0, 0, 774, 569) target: self.bounds];
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 774, resizedFrame.size.height / 569);
    
    NSLog(@"%s", __func__);
    UIColor* strokeColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* fillColor = [UIColor colorWithRed: 0.8 green: 0.8 blue: 0.8 alpha: 1];
    NSLog(@"%@", self.mapPath);
    [self.mapPath.pathArray enumerateObjectsUsingBlock:^(UIBezierPath *path, NSUInteger idx, BOOL * _Nonnull stop) {
        [fillColor setFill];
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
