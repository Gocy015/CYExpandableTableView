//
//  CustomHeaderView.m
//  CYExpandableTableView-master
//
//  Created by Gocy on 16/8/16.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#import "CustomHeader.h"

@implementation CustomHeader


#pragma mark - Custom Header Protocol

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0.5;
    }
    return self;
}


-(void)animateOpenChange:(BOOL)opened{
    if (opened) {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
        }];
    }
    else{
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0.5;
        }];
    }
}




@end
