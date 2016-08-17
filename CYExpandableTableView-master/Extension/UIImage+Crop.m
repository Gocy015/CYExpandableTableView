//
//  UIImage+Resize.m
//  CYExpandableTableView-master
//
//  Created by Gocy on 16/8/17.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#import "UIImage+Crop.h"

@implementation UIImage(Crop)

-(UIImage *)cropImageInRect:(CGRect)rect{
    
    CGRect selfRect = CGRectMake(0, 0, self.size.width, self.size.height);
    if (!CGRectContainsRect(selfRect, rect)) {
        return nil;
    }
    
    CGImageRef cg = CGImageCreateWithImageInRect(self.CGImage, rect);
    
    return [UIImage imageWithCGImage:cg];
    
}

@end
