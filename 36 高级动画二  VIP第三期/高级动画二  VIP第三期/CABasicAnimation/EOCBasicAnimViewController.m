//
//  EOCBasicAnimViewController.m
//  高级动画二  VIP第三期
//
//  Created by 八点钟学院 on 2018/5/7.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCBasicAnimViewController.h"
#import "EOCShapeLayer.h"

@interface EOCBasicAnimViewController () {
    
    EOCShapeLayer *shapeLayer;
    
}

@end

@implementation EOCBasicAnimViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //监听动画执行过程中值的改变
    shapeLayer = [EOCShapeLayer layer];
    shapeLayer.frame = CGRectMake(100.f, 100.f, 100.f, 100.f);
    shapeLayer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"color"];
    anim.duration = 4.f;
    anim.fromValue = (__bridge id)[UIColor yellowColor].CGColor;
    anim.toValue = (__bridge id)[UIColor greenColor].CGColor;
    [shapeLayer addAnimation:anim forKey:nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    //监听呈现 不行
//    [shapeLayer.presentationLayer addObserver:self forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew context:nil];
    
    //监听数据层
    [shapeLayer.modelLayer addObserver:self forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    shapeLayer.backgroundColor = [UIColor greenColor].CGColor;

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"bgcolor changed");
    
}

@end
