//
//  ViewController.m
//  高级动画二  VIP第三期
//
//  Created by 八点钟学院 on 2018/5/6.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate> {
    
    CALayer *layer;
    CABasicAnimation *anim;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"动画代理";
    
    layer = [CALayer layer];
    layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    layer.frame = CGRectMake(100.f, 100.f, 100.f, 100.f);
    [self.view.layer addSublayer:layer];
    
    //动画
    anim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anim.toValue = (__bridge id)[UIColor redColor].CGColor;
    anim.duration = 4.f;
    anim.delegate = self;
    [layer addAnimation:anim forKey:nil];
    
}

//1. 代理里面的animOne是anim的深拷贝,判断是不是这个动画要用animOne.keyPath
- (void)animationDidStop:(CABasicAnimation *)animOne finished:(BOOL)flag {
    if (animOne == anim) {
        NSLog(@"两个相同的animation");
    }
    if ([animOne.keyPath isEqualToString:@"backgroundColor"]) {
        NSLog(@"背景颜色的改变");
    }
}

@end
