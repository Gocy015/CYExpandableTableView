//
//  ExpandableTableViewController.h
//  TrackDown
//
//  Created by Gocy on 16/7/22.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandableObjectProtocol.h"
#import "CustomExpandableViewProtocol.h"

@protocol ExpandableTableViewEventDelegate <UITableViewDelegate>

-(void)didSelectHeaderAnIndex:(NSUInteger)index;

@end

@interface CYExpandableTableViewController : UIViewController

@property (nonatomic ,strong) NSArray <id<ExpandableObject>>*data;

@property (nonatomic ,strong) UIColor *normalHeaderFillColor;
@property (nonatomic ,strong) UIColor *normalHeaderTextColor;
@property (nonatomic ,strong) UIColor *selectedHeaderFillColor;
@property (nonatomic ,strong) UIColor *selectedHeaderTextColor;
@property (nonatomic ,strong) UIColor *headerSeperatorColor;
@property (nonatomic) CGFloat headerSeperatorHeight;

@property (nonatomic ,weak) id <CustomHeaderViewDataSource> headerViewDataSource;
@property (nonatomic ,weak) id <CustomCellDataSource> cellDataSource;
@property (nonatomic ,weak) id <ExpandableTableViewEventDelegate> eventDelegate;

@property (nonatomic) BOOL allowsMutipleSelection;

@end
