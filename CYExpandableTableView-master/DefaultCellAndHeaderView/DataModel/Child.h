//
//  Child.h
//  CYExpandableTableView-master
//
//  Created by Gocy on 16/8/16.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Child : NSObject

@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *gender;
@property (nonatomic) NSInteger age;

-(NSString *)childInfo;

@end
