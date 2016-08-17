//
//  Child.m
//  CYExpandableTableView-master
//
//  Created by Gocy on 16/8/16.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#import "Child.h"

@implementation Child

-(NSString *)childInfo{
    return [NSString stringWithFormat:@"Name : %@ , Gender: %@ , Age : %lu",_name,_gender,(long)_age];
}

@end
