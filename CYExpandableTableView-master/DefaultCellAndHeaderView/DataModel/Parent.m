//
//  Parent.m
//  CYExpandableTableView-master
//
//  Created by Gocy on 16/8/16.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#import "Parent.h"
#import "Child.h"
#import "NSArray+Map.h"

@interface Parent (){
    BOOL _opened;
}

@end

@implementation Parent


#pragma mark - Expandable Object Protocol

-(NSString *)description{
    return _name;
}

-(NSUInteger)countOfSecondaryObjects{
    return _children.count;
}

-(NSArray *)descriptionForSecondaryObjects{
    return [_children map:^NSString *(Child *child) {
        return [child childInfo];
    }];
}

-(void)setOpened:(BOOL)opened{
    _opened = opened;
}

-(BOOL)opened{
    return _opened;
}

@end
