//
//  Hospital.m
//  HttpRequestDemo
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 yms. All rights reserved.
//

#import "Hospital.h"

@implementation Hospital

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"id_hospital" : @"id"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"floor_plan" : [NSString class]
             };
}

@end
