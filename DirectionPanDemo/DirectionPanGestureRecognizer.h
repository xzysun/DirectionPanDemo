//
//  DirectionPanGestureRecognizer.h
//  DirectionPanDemo
//
//  Created by xzysun on 15/4/2.
//  Copyright (c) 2015年 netease. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, PanGestureRecognizerDirection) {
    PanGestureRecognizerDirectionRight = 1 << 0,
    PanGestureRecognizerDirectionLeft = 1 << 1,
    PanGestureRecognizerDirectionUp = 1 << 2,
    PanGestureRecognizerDirectionDown = 1 << 3,
};

@interface DirectionPanGestureRecognizer : UIPanGestureRecognizer

/**
 *  允许拖动的方向，默认是上下左右四个方向
 */
@property (nonatomic, assign) PanGestureRecognizerDirection direction;
@end
