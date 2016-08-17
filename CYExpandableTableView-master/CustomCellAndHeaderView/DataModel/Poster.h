//
//  Poster.h
//  CYExpandableTableView-master
//
//  Created by Gocy on 16/8/17.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExpandableObjectProtocol.h"
@class Detail;

@interface Poster : NSObject <ExpandableObject>

@property (nonatomic ,copy) NSString *imageUrl;
@property (nonatomic ,strong) NSArray <Detail *> *details;

@end
