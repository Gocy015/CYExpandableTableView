//
//  Poster.m
//  CYExpandableTableView-master
//
//  Created by Gocy on 16/8/17.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#import "Poster.h"

@interface Poster (){
    BOOL _opened;
}

@end

@implementation Poster


//-(NSString *)description{
//    return nil;
//}

-(NSUInteger)countOfSecondaryObjects{
    return _details.count;
}

//-(NSArray *)descriptionForSecondaryObjects{
//    return nil;
//}

-(void)setOpened:(BOOL)opened{
    _opened = opened;
}

-(BOOL)opened{
    return _opened;
}
@end
