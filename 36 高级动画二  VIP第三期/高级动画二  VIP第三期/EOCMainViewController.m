//
//  EOCMainViewController.m
//  高级动画二  VIP第三期
//
//  Created by 八点钟学院 on 2018/5/7.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCMainViewController.h"
#import "ViewController.h"
#import "EOCBezierPathViewController.h"
#import "EOCBasicAnimViewController.h"
#import "EOCKeyFrameAnimationViewController.h"
#import "EOCCAMediaTimingViewController.h"
#import "EOCAnimationCaseViewController.h"
#import "EOCTransitionViewController.h"

@interface EOCMainViewController ()

@end

@implementation EOCMainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 64.f, self.view.frame.size.width, self.view.frame.size.height-64.f)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+150.f);
    [self.view addSubview:scrollView];
    
    self.navigationItem.title = @"八点钟学院";
    
    NSArray *titleArr = @[@"动画代理", @"贝塞尔曲线", @"基础动画", @"关键帧动画", @"时间函数", @"过渡转场动画", @"动画案例"];
    
    for (int i=0; i<titleArr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(100.f, 50.f+100.f*i, 200.f, 50.f);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256.f)/255.f green:arc4random_uniform(256.f)/255.f blue:arc4random_uniform(256.f)/255.f alpha:1.f];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [btn setAccessibilityValue:[NSString stringWithFormat:@"%d", i]];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btn];
        
    }
    
}

- (void)btnAction:(UIButton *)btn {
    
    int index = btn.accessibilityValue.intValue;
    
    if (0 == index) {  //动画代理
        
        ViewController *viewCtrl = [[ViewController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    } else if (1 == index) {  //贝塞尔曲线
        
        EOCBezierPathViewController *viewCtrl = [[EOCBezierPathViewController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    } else if (2 == index) {   //基础动画
        
        EOCBasicAnimViewController *viewCtrl = [[EOCBasicAnimViewController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    } else if (3 == index) {   //关键帧动画
        
        EOCKeyFrameAnimationViewController *viewCtrl = [[EOCKeyFrameAnimationViewController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    }  else if (4 == index) {   //时间函数
        
        EOCCAMediaTimingViewController *viewCtrl = [[EOCCAMediaTimingViewController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    }  else if (5 == index) {   //过渡转场函数
        
        EOCTransitionViewController *viewCtrl = [[EOCTransitionViewController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    } else if (6 == index) {   //动画案例
        
        EOCAnimationCaseViewController *viewCtrl = [[EOCAnimationCaseViewController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    }
    
}



@end
