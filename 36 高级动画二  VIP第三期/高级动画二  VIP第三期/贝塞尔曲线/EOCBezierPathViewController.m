//
//  EOCBezierPathViewController.m
//  高级动画二  VIP第三期
//
//  Created by 八点钟学院 on 2018/5/7.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCBezierPathViewController.h"

@interface EOCBezierPathViewController () {
    
    CAShapeLayer *layer;
    
}

@end

@implementation EOCBezierPathViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"贝塞尔曲线";
    
    [self animationCaseOne];
    //[self animationCaseTwoMethod1];
    //[self animationCaseTwoMethod2];
    //[self animationCaseTwoMethod3];
}

- (void)animationCaseOne {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-mine.png"]];
    imageView.frame = CGRectMake(100.f, 200.f, 100.f, 100.f);
    imageView.clipsToBounds = YES;
    [self.view addSubview:imageView];
    
    //添加一层浅白色layer
    layer = [CAShapeLayer layer];
    
    //CAShapeLayer占用空间比较少,CAShapeLayer和UIBezierPath是黄金搭档
    /*
     圆心
     半径
     开始角度
     结束角度
     顺时针
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50.f, 50.f) radius:50.f startAngle:-M_PI_2 endAngle:3*M_PI/2 clockwise:YES];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor; //填充色,默认是黑色的
    layer.strokeColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f].CGColor; //绘制色
    //线宽设置为半径100
    layer.lineWidth = 100.f;
    
    [imageView.layer addSublayer:layer];
}

/*
 shapelayer.fillRule:1、kCAFillRuleEvenOdd 2、kCAFillRulenonzero
 
 nonzero字面意思是“非零”。按该规则，要判断一个点是否在图形内，从该点作任意方向的一条射线，然后检测射线与图形路径的交点情况。从0开始计数，路径从左向右穿过射线则计数加1，从右向左穿过射线则计数减1。得出计数结果后，如果结果是0，则认为点在图形外部，否则认为在内部
 evenodd字面意思是“奇偶”。按该规则，要判断一个点是否在图形内，从该点作任意方向的一条射线，然后检测射线与图形路径的交点的数量。如果结果是奇数则认为点在内部，是偶数则认为点在外部
 */
- (void)animationCaseTwoMethod1 {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-mine.png"]];
    imageView.frame = CGRectMake(100.f, 200.f, 100.f, 100.f);
    [self.view addSubview:imageView];
    
    //矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0.f, 0.f, 100.f, 100.f)];
    [path addArcWithCenter:CGPointMake(50.f, 50.f) radius:50.f startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillRule = kCAFillRuleEvenOdd; //改变判断是不是在圆内的规则
    
    layer.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f].CGColor; //然后画上去
    [imageView.layer addSublayer:layer];
}

- (void)animationCaseTwoMethod2 {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-mine.png"]];
    imageView.frame = CGRectMake(100.f, 200.f, 100.f, 100.f);
    [self.view addSubview:imageView];
    
    //rct
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0.f, 0.f, 100.f, 100.f)];
    UIBezierPath *pathOne = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50.f, 50.f) radius:50.f startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [path appendPath:[pathOne bezierPathByReversingPath]]; //两条线当成一条线
    
    layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    
    layer.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f].CGColor; //然后画上去
    [imageView.layer addSublayer:layer];
}

- (void)animationCaseTwoMethod3 {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-mine.png"]];
    imageView.frame = CGRectMake(100.f, 200.f, 100.f, 100.f);
    [self.view addSubview:imageView];
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 100.f, 100.f)];
    maskView.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.4f];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0.f, 0.f, 100.f, 100.f)];
    UIBezierPath *pathOne = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50.f, 50.f) radius:50.f startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [path appendPath:[pathOne bezierPathByReversingPath]];
    
    layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    
    maskView.layer.mask = layer; //layer的遮罩就是我们画出的两条线
    
    [imageView addSubview:maskView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //strokeStart单位属性0-1 开始画 结束画
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    anim.duration = 4.f;
    anim.fromValue = @0;
    anim.toValue = @1;
    [layer addAnimation:anim forKey:nil];
}

@end
