//
//  EOCAnimationCaseView.m
//  高级动画二  VIP第三期
//
//  Created by 八点钟学院 on 2018/5/7.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCAnimationCaseView.h"

@interface EOCAnimationCaseView () {
        
        CAShapeLayer *topLineLayer;
        CAShapeLayer *leftLineLayer;
        CAShapeLayer *bottomLineLayer;
        CAShapeLayer *rightLineLayer;
    
}
@end

@implementation EOCAnimationCaseView

#define firstColor    [UIColor colorWithRed:90 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.0]
#define secondColor   [UIColor colorWithRed:250 / 255.0 green:85 / 255.0 blue:78 / 255.0 alpha:1.0]
#define thirdColor    [UIColor colorWithRed:92 / 255.0 green:201 / 255.0 blue:105 / 255.0 alpha:1.0]
#define fourthColor   [UIColor colorWithRed:253 / 255.0 green:175 / 255.0 blue:75 / 255.0 alpha:1.0]

- (instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(100.0f, 200.0f, 80.0f, 80.0f);
        self.backgroundColor = [UIColor lightGrayColor];
        [self createLayer];
    }
    
    return self;
}

- (void)createLayer {
    
    //新建四条不同颜色的线
    CGPoint topPoint = CGPointMake(3*80.f/4, 5.f);
    CGPoint leftPoint = CGPointMake(5.f, 80.f/4);
    CGPoint bottomPoint = CGPointMake(80.f/4, 80.f-5.f);
    CGPoint rightPoint = CGPointMake(80.f-5.f, 3*80.f/4);
    
    CGFloat lineLength = 80.f - 2*5.f;
    
    topLineLayer = [self createLineLayer:topPoint toPoint:CGPointMake(topPoint.x , topPoint.y + lineLength) withColor:firstColor];
    leftLineLayer = [self createLineLayer:leftPoint toPoint:CGPointMake(leftPoint.x + lineLength , leftPoint.y) withColor:secondColor];
    bottomLineLayer = [self createLineLayer:bottomPoint toPoint:CGPointMake(bottomPoint.x , bottomPoint.y - lineLength) withColor:thirdColor];
    rightLineLayer = [self createLineLayer:rightPoint toPoint:CGPointMake(rightPoint.x - lineLength , rightPoint.y) withColor:fourthColor];
    
    [self.layer addSublayer:topLineLayer];
    [self.layer addSublayer:leftLineLayer];
    [self.layer addSublayer:bottomLineLayer];
    [self.layer addSublayer:rightLineLayer];
    
    self.transform = CGAffineTransformMakeRotation(-M_PI/6);
    
}

- (CAShapeLayer *)createLineLayer:(CGPoint)fromPoint toPoint:(CGPoint)toPoint withColor:(UIColor *)color {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:fromPoint];
    [path addLineToPoint:toPoint];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineCap = kCALineCapRound;
    layer.strokeColor = color.CGColor;
    layer.lineWidth = 10.f;
    layer.opacity = 0.8f;
    
    layer.path = path.CGPath;
    return layer;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self createAnimations];
    
}

- (void)createAnimations {
    
    //自身旋转
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anim.toValue = @(M_PI*2-M_PI/6);
    anim.duration = 3.5f;
    anim.repeatDuration = 7.f;
    [self.layer addAnimation:anim forKey:nil];
    
    //让线条缩短
    [self createLineLayerAnim:topLineLayer pointX:0.f pointY:15.f];
    [self createLineLayerAnim:leftLineLayer pointX:15.f pointY:0.f];
    [self createLineLayerAnim:bottomLineLayer pointX:0.f pointY:-15.f];
    [self createLineLayerAnim:rightLineLayer pointX:-15.f pointY:0.f];
    
    //此时停止了旋转，让线条变长
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anim1.fillMode = kCAFillModeForwards;
    anim1.removedOnCompletion = NO;
    anim1.beginTime = CACurrentMediaTime() + 7.f;
    anim1.fromValue = @0;
    anim1.toValue = @1;
    anim1.duration = 3.f;
    [topLineLayer addAnimation:anim1 forKey:nil];
    [leftLineLayer addAnimation:anim1 forKey:nil];
    [bottomLineLayer addAnimation:anim1 forKey:nil];
    [rightLineLayer addAnimation:anim1 forKey:nil];
    
    //self变大
    CAKeyframeAnimation *anim3 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    anim3.duration = 8.0f;
    anim3.beginTime = CACurrentMediaTime()+7.0f;
    NSValue *fromValue = @1;
    NSValue *toValue = @1.2;
    
    anim3.keyTimes = @[@0.1, @0.4, @0.5];
    anim3.values = @[fromValue, toValue, fromValue];
    [self.layer addAnimation:anim3 forKey:nil];
}

- (void)createLineLayerAnim:(CAShapeLayer *)layer pointX:(CGFloat)pointx pointY:(CGFloat)pointy {
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.fromValue = @1;
    anim.toValue = @0;
    anim.duration = 3.f;
    [layer addAnimation:anim forKey:nil];
    
    //让这个点前后有位移
    CAKeyframeAnimation *anim1 = [CAKeyframeAnimation animation];
    anim1.keyPath = @"transform";  //课堂上这里是transform.translation 所以没效果，因为我的fromValue值设置的就是transform的值
    anim1.repeatDuration = 4.0f;
    anim1.beginTime = CACurrentMediaTime()+3.0f;
    anim1.duration = 1.0f;
    NSValue *fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0.f)];
    NSValue *toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(pointx, pointy, 0.f)];
    anim1.values = @[fromValue, toValue, fromValue, toValue, fromValue];
    [layer addAnimation:anim1 forKey:nil];
    
}

@end
