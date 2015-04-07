//
//  DirectionPanGestureRecognizer.m
//  DirectionPanDemo
//
//  Created by xzysun on 15/4/2.
//  Copyright (c) 2015年 netease. All rights reserved.
//

#import "DirectionPanGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

static const CGFloat PanTriggerDistance = 10.0;

@interface DirectionPanGestureRecognizer ()

@property (nonatomic, assign) CGPoint beginPoint;
@end

@implementation DirectionPanGestureRecognizer

-(instancetype)initWithTarget:(id)target action:(SEL)action
{
    if (self = [super initWithTarget:target action:action]) {
        //init
        _direction = PanGestureRecognizerDirectionRight|PanGestureRecognizerDirectionLeft|PanGestureRecognizerDirectionUp|PanGestureRecognizerDirectionDown;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.beginPoint = [(UITouch *)[touches anyObject] locationInView:self.view];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint current = [(UITouch *)[touches anyObject] locationInView:self.view];
    if (!CGRectContainsPoint(self.view.bounds, current)) {
        //移出视图外面，结束
        [self ignoreTouch:[touches anyObject] forEvent:event];
        self.state = UIGestureRecognizerStateCancelled;
        return;
    }
    CGPoint movement = CGPointMake(current.x-self.beginPoint.x, current.y-self.beginPoint.y);
    if ((movement.x > PanTriggerDistance)&&(_direction&PanGestureRecognizerDirectionRight)) {
        //可以向右拖动
        [super touchesMoved:touches withEvent:event];
    } else if ((movement.x < -PanTriggerDistance)&&(_direction&PanGestureRecognizerDirectionLeft)&&(fabs(movement.x)>fabs(movement.y))) {
        //可以向座拖动
        [super touchesMoved:touches withEvent:event];
    } else if ((movement.y > PanTriggerDistance)&&(_direction&PanGestureRecognizerDirectionDown)&&(fabs(movement.y)>fabs(movement.x))) {
        //可以向下拖动
        [super touchesMoved:touches withEvent:event];
    } else if ((movement.y < -PanTriggerDistance)&&(_direction&PanGestureRecognizerDirectionUp)&&(fabs(movement.y)>fabs(movement.x))) {
        //可以向上拖动
        [super touchesMoved:touches withEvent:event];
    } else if ((fabs(movement.x)<PanTriggerDistance)&&(fabs(movement.y)<PanTriggerDistance)){
        //初始移动距离不够判断
        NSLog(@"移动距离还不够判断");
        self.state = UIGestureRecognizerStatePossible;
//    } else if (((fabs(movement.x)<fabs(movement.y))&&!((_direction&PanGestureRecognizerDirectionLeft)||(_direction&PanGestureRecognizerDirectionRight)))||((fabs(movement.x>fabs(movement.y)))&&!((_direction&PanGestureRecognizerDirectionUp)||(_direction&PanGestureRecognizerDirectionDown)))) {
//        [self ignoreTouch:[touches anyObject] forEvent:event];
//        self.state = UIGestureRecognizerStateFailed;
    } else {
        //需要结束移动
        [self ignoreTouch:[touches anyObject] forEvent:event];
        self.state = UIGestureRecognizerStateFailed;
//        [self reset];
//        self.state = UIGestureRecognizerStateEnded;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

-(void)reset
{
    [super reset];
    self.beginPoint = CGPointZero;
}
@end
