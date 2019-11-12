//
//  EOCShapeLayer.m
//  高级动画二  VIP第三期
//
//  Created by 八点钟学院 on 2018/5/7.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCShapeLayer.h"

@implementation EOCShapeLayer

+ (BOOL)needsDisplayForKey:(NSString *)key {  //监听相应的key，如果返回yes，就会调用display方法
    
    if ([key isEqualToString:@"color"]) {

        return YES;

    }
    
    return [super needsDisplayForKey:key];
    
}

- (void)display {
    
    NSLog(@"color: %@", self.presentationLayer.color);
    self.backgroundColor = self.presentationLayer.color;
    [super display];
    
}

@end
