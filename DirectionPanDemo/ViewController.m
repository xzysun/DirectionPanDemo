//
//  ViewController.m
//  DirectionPanDemo
//
//  Created by xzysun on 15/4/2.
//  Copyright (c) 2015年 netease. All rights reserved.
//

#import "ViewController.h"
#import "DirectionPanGestureRecognizer.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *demoView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DirectionPanGestureRecognizer *gesture = [[DirectionPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandler:)];
    gesture.direction = PanGestureRecognizerDirectionRight|PanGestureRecognizerDirectionLeft;
//    gesture.direction = PanGestureRecognizerDirectionRight;
    [self.demoView addGestureRecognizer:gesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)panGestureHandler:(DirectionPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Pan began");
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        NSLog(@"gesture translation:%@", NSStringFromCGPoint([gesture translationInView:self.demoView]));
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Pan ended");
    } else if (gesture.state == UIGestureRecognizerStateCancelled) {
        NSLog(@"Pan cancelled");
    } else if (gesture.state == UIGestureRecognizerStateFailed) {
        NSLog(@"Pan failed");
    }
}
@end
