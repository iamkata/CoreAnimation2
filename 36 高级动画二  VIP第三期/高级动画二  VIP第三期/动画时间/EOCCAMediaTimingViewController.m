//
//  EOCCAMediaTimingViewController.m
//  高级动画二  VIP第三期
//
//  Created by 八点钟学院 on 2018/5/7.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCCAMediaTimingViewController.h"

@interface EOCCAMediaTimingViewController ()<CAAnimationDelegate> {
    
    CAShapeLayer *shapeLayer;
    int i; //是否暂停
    CFTimeInterval pausedTime; //暂停时间
    
}

@end

@implementation EOCCAMediaTimingViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    i = 0;
    
    //1.跟时间相关的要掌握：beginTime  speed  timeOffset
    
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.contents = (__bridge id)[UIImage imageNamed:@"plane.png"].CGImage;
    shapeLayer.speed = 0.f; //默认1
    shapeLayer.bounds = CGRectMake(0.f, 0.f, 50.f, 50.f);
    shapeLayer.position = CGPointMake(25.f, 100.f);
    
    [self.view.layer addSublayer:shapeLayer];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(25.f, 100.f)];
    [path addLineToPoint:CGPointMake(300.f, 300.f)];
    lineLayer.lineWidth = 2.f;
    lineLayer.strokeColor = [UIColor redColor].CGColor;
    lineLayer.path = path.CGPath;
    [self.view.layer addSublayer:lineLayer];
    
    //CAKeyframeAnimation使用UIBezierPath当做路径,优先使用路径而不是values
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.duration = 10.f;
//    anim.beginTime = CACurrentMediaTime() + 5.f;  //让动画推迟5s执行,默认马上执行
    anim.path = path.CGPath;
//    anim.autoreverses = YES; //动画是否原路返回回到起点,默认是NO
//    anim.timeOffset = 3.f;
    [shapeLayer addAnimation:anim forKey:nil];
    
    //新建UISlider, 改变timeOffset
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(100.f, 300.f, 200.f, 30.f)];
    slider.minimumValue = 0.f;
    slider.maximumValue = 10.f;
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
}

- (void)sliderAction:(UISlider *)slider {
    shapeLayer.timeOffset = slider.value;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // t（本层的时间） = (tp（父层的时间） - begin) * speed + timeOffset
    if (0 == i) {   //暂停
        pausedTime = [shapeLayer convertTime:CACurrentMediaTime() fromLayer:nil];
        shapeLayer.speed = 0.f;
        shapeLayer.timeOffset = pausedTime;
    } else if (1 == i) {      //启动
        //  t = (tp - begin) * speed + offset
        shapeLayer.speed = 1.f;
        shapeLayer.beginTime = CACurrentMediaTime();
    }
    i++;
    i %= 2;
}

@end
