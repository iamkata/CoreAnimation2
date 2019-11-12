//
//  EOCKeyFrameAnimationViewController.m
//  高级动画二  VIP第三期
//
//  Created by 八点钟学院 on 2018/5/7.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCKeyFrameAnimationViewController.h"

@interface EOCKeyFrameAnimationViewController ()<CAAnimationDelegate> {
    
    CAShapeLayer *shapeLayer;
    UIBezierPath *path;
    
}

@end

@implementation EOCKeyFrameAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(40.f, 175.f)];
    [path addCurveToPoint:CGPointMake(300.f, 175.f) controlPoint1:CGPointMake(50.f, 40.f) controlPoint2:CGPointMake(200.f, 300.f)];
    pathLayer.path = path.CGPath;
    pathLayer.lineWidth = 2.f;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    
    [pathLayer setStrokeColor:[UIColor redColor].CGColor];
    [self.view.layer addSublayer:pathLayer];
    
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.contents = (__bridge id)[UIImage imageNamed:@"plane.png"].CGImage;
    shapeLayer.bounds = CGRectMake(0.f, 0.f, 50.f, 50.f);
    shapeLayer.position = CGPointMake(40.f, 175.f);
    [self.view.layer addSublayer:shapeLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    anim.duration = 4.f;
    anim.repeatCount = 1;
    anim.rotationMode = kCAAnimationRotateAuto;
//    anim.autoreverses = YES;
    anim.calculationMode = kCAAnimationCubicPaced;  //如果用keyTimes和values，会卡顿着走，用这个平滑一些
    anim.path = path.CGPath;
    
    anim.keyTimes = @[@0.4, @0.7, @0.9];
    anim.values = @[[NSValue valueWithCGPoint:CGPointMake(60, 200)], [NSValue valueWithCGPoint:CGPointMake(100, 200)], [NSValue valueWithCGPoint:CGPointMake(140, 200)]];
    
    [shapeLayer addAnimation:anim forKey:nil];
}



@end
