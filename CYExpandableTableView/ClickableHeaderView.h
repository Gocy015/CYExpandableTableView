//
//  ClickableHeaderView.h
//  TrackDown
//
//  Created by Gocy on 16/7/22.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClickableHeaderView;
@protocol CustomHeaderView;

@protocol ClickableHeaderDelegate <NSObject>

-(void)didClickHeaderView:(ClickableHeaderView *)headerView;

@end

@interface ClickableHeaderView : UITableViewHeaderFooterView


-(void)installCustomView:(UIView *)view;

@property (nonatomic ,weak) id <ClickableHeaderDelegate> delegate;
@property (nonatomic) NSUInteger section;
@property (nonatomic) BOOL opened;
@property (nonatomic ,copy) NSString *headerText;
@property (nonatomic ,weak) UIView <CustomHeaderView>*customView;


@property (nonatomic ,strong) UIColor *normalFillColor;
@property (nonatomic ,strong) UIColor *normalTextColor;
@property (nonatomic ,strong) UIColor *selectedFillColor;
@property (nonatomic ,strong) UIColor *selectedTextColor;
@property (nonatomic ,strong) UIColor *seperatorColor;
@property (nonatomic) CGFloat seperatorHeight;


@end
