//
//  EOCAnimationCaseViewController.m
//  高级动画二  VIP第三期
//
//  Created by 八点钟学院 on 2018/5/7.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCAnimationCaseViewController.h"
#import "EOCAnimationCaseView.h"

@interface EOCAnimationCaseViewController ()

@end

@implementation EOCAnimationCaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    EOCAnimationCaseView *caseView = [[EOCAnimationCaseView alloc] init];
    [self.view addSubview:caseView];
}



@end
