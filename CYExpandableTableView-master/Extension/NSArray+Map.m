//
//  NSArray+Map.m
//  TrackDown
//
//  Created by Gocy on 16/7/11.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#import "NSArray+Map.h"

@implementation NSArray(Map)

-(NSArray *)map:(NSObject *(^)(__kindof NSObject *))mapblock{
    NSMutableArray *arr = [NSMutableArray new];
    for (NSObject *obj in self) {
        [arr addObject:mapblock(obj)];
    }
    return [[NSArray alloc]initWithArray:arr];
}

-(NSNumber *)sum{
    double sum = 0;
    for (NSObject *obj in self) {
        NSAssert([obj isKindOfClass:[NSNumber class]], @"calling sum on an non-numeric array");
        sum += [((NSNumber *)obj) doubleValue];
    }
    return @(sum);
}

@end
