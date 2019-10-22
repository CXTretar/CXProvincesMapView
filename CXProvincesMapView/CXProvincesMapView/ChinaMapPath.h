//
//  ChinaMapPath.h
//  CXProvincesMapView
//
//  Created by Felix on 2019/4/29.
//  Copyright © 2019 CXTretar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChinaMapPath : NSObject {
    NSArray *_pathArray;
    NSArray *_textArray;
    NSArray *_textRectArray;
    NSArray *_pinPointArray;
}

@property(nonatomic, copy) NSArray *pathArray;
@property(nonatomic, copy) NSArray *textArray;
@property(nonatomic, copy) NSArray *textRectArray;
@property(nonatomic, copy) NSArray *pinPointArray;

@end

