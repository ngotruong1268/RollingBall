//
//  ViewController.m
//  RollingBall
//
//  Created by Ngô Sỹ Trường on 4/27/16.
//  Copyright © 2016 ngotruong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView* ball;
    NSTimer* timer;
    CGFloat angle;
    CGFloat ballRadius;
    CGFloat deltaAngle;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBall];
    angle = 0.0;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.005
                                             target:self
                                           selector:@selector(rollBall)
                                           userInfo:nil
                                            repeats:true];
    //    [self viewWillDisappear:timer];
}
-(void) addBall {
    CGSize mainViewSize = self.view.bounds.size;
    ball = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"football.png"] ];
    ballRadius = 32.0;
    ball.center = CGPointMake(ballRadius, mainViewSize.height * 0.5);
    [self.view addSubview:ball];
}

-(void) rollBall {
    deltaAngle = 0.1;
    angle += deltaAngle;
    ball.transform = CGAffineTransformMakeRotation(angle);
    ball.center = CGPointMake(ball.center.x + ballRadius*deltaAngle, ball.center.y);
    if (ball.center.x > (self.view.bounds.size.width - ballRadius)) {
        [timer invalidate];
        angle = 0;
        timer = [NSTimer scheduledTimerWithTimeInterval:0.005
                                                 target:self
                                               selector:@selector(rollballChange)
                                               userInfo:nil
                                                repeats:true];

    }
}
-(void) rollballChange {
    deltaAngle = -0.1;
    angle -= deltaAngle;
    ball.transform = CGAffineTransformMakeRotation(-angle);
    ball.center = CGPointMake(ball.center.x + (ballRadius*deltaAngle), ball.center.y);
    if (ball.center.x < ballRadius) {
        [timer invalidate];
        angle = 0;
        timer = [NSTimer scheduledTimerWithTimeInterval:0.005
                                                 target:self
                                               selector:@selector(rollBall)
                                               userInfo:nil
                                                repeats:true];
    }
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
}


@end
