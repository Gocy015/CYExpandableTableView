//
//  NSArray+Map.h
//  TrackDown
//
//  Created by Gocy on 16/7/11.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(Map)

-(NSArray *)map:(NSObject * (^)(__kindof NSObject *))mapblock;
-(NSNumber *)sum;

@end
