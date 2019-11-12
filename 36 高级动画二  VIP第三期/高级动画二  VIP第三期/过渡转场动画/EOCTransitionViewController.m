//
//  EOCTransitionViewController.m
//  高级动画二
//
//  Created by 八点钟学院 on 2017/6/14.
//  Copyright © 2017年 八点钟学院. All rights reserved.
//  206页

#import "EOCTransitionViewController.h"

@interface EOCTransitionViewController () {
    
    CAShapeLayer *shapeLayer;
    
}

@end

@implementation EOCTransitionViewController


//合法的转场动画类型有：
//fade：默认。faker淡出，layer淡入
//moveIn：layer移入覆盖faker
//push：layer推入，faker推出
//reveal：覆盖在layer上面的faker被移出

//私有：（被苹果ban了，不建议直接使用）
//cube：立方体旋转，layer将会在呈现的面，faker在不可见的面
//suckEffect：覆盖在layer上面的faker被抽离
//oglFlip：将背面的layer翻转到前面，faker翻转到背面、、
//rippleEffect：伴随着水面波动动画，faker淡出，layer淡入
//pageCurl：翻到下一页，faker被翻走，呈现layer
//pageUnCurl：翻回上一页，layer被翻回并覆盖faker
//cameraIrisHollowOpen：下面这两个是特殊的。镜头开，同时呈现部分为透明，而不是layer
//cameraIrisHollowClose：类似上面，镜头关

//subtype
//4个子类型，表示上左下右4个转场动画方向：
//fromTop
//fromLeft
//fromBottom
//fromRight

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.contents = (__bridge id)[UIImage imageNamed:@"plane.png"].CGImage;
    shapeLayer.frame = CGRectMake(25.f, 75.f, 50.f, 50.f);
    [self.view.layer addSublayer:shapeLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CATransition *anim = [CATransition animation];  //CATransaction事务
    anim.type = @"cube";
    anim.subtype = kCATransitionFromRight;
    
    anim.duration = 4.f;
    [shapeLayer addAnimation:anim forKey:nil];
    
    shapeLayer.contents = (__bridge id)[UIImage imageNamed:@"bg-mine.png"].CGImage;
}

@end
