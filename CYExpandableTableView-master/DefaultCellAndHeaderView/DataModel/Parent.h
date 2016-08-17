//
//  Parent.h
//  CYExpandableTableView-master
//
//  Created by Gocy on 16/8/16.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExpandableObjectProtocol.h"

@class Child;

@interface Parent : NSObject <ExpandableObject>

@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,strong) NSArray <Child *> *children;

@end
