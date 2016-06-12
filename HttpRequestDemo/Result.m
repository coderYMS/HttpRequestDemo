//
//  Result.m
//  HttpRequestDemo
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 yms. All rights reserved.
//

#import "Result.h"
#import "Hospital.h"
//#import <YYModel.h>

@implementation Result

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"hospitalList" : [Hospital class]
             };
}

@end
