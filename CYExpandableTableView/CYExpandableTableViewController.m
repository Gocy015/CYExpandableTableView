//
//  CYExpandableTableViewController.m
//  TrackDown
//
//  Created by Gocy on 16/7/22.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#import "CYExpandableTableViewController.h"
#import "ClickableHeaderView.h"

static NSString *const cellReuseId = @"secondaryCell";
static NSString *const headerReusedId = @"clickableHeader";
static CGFloat headerHeight = 40.0f;

@interface CYExpandableTableViewController () <UITableViewDelegate ,UITableViewDataSource ,ClickableHeaderDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSInteger lastSelectedSection;

@end



@implementation CYExpandableTableViewController

#pragma mark - Life Cycle

-(instancetype)init{
    if (self = [super init]) {
        _allowsMutipleSelection = YES;
        _lastSelectedSection = -1;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self constructTableView];
    
    self.headerSeperatorHeight = 6;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    self.tableView.tableFooterView = [UIView new];
    
    if (self.cellDataSource) {
        [self.cellDataSource registerCellReuseIdForTableView:self.tableView];
    }else{
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseId];
    }
    
    
    
    [self.tableView registerClass:[ClickableHeaderView class] forHeaderFooterViewReuseIdentifier:headerReusedId];
    
    
}

-(void)dealloc{
    NSLog(@"CYExpandableTableView Dealloc");
}


#pragma mark - Helpers

-(void)constructTableView{
    UITableView *tableView = [UITableView new];
    self.tableView = tableView;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
}


#pragma mark - UITableView Deleagate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.eventDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.eventDelegate scrollViewDidScroll:scrollView];
    }
}

#pragma mark - UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data ? self.data.count : 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.data) {
        if ([self.data[section] opened]) {
            
            return [self.data[section] countOfSecondaryObjects];
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.headerViewDataSource) {
        if (self.headerSeperatorHeight >= 0) {
            
            return [self.headerViewDataSource heightForHeaderViewInSection:section] + self.headerSeperatorHeight;
        }
        return [self.headerViewDataSource heightForHeaderViewInSection:section] + 6;
    }
    return headerHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellDataSource) {
        return [self.cellDataSource heightForCellAtIndexPath:indexPath];
    }
    return 30;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ClickableHeaderView *header = (ClickableHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReusedId];
    
    header.delegate = self;
    
    header.section = section;
    
    header.opened = [self.data[section] opened];
    
    if (self.headerSeperatorColor) {
        header.seperatorColor = self.headerSeperatorColor;
    }
    if (self.headerSeperatorHeight >= 0) {
        header.seperatorHeight = self.headerSeperatorHeight;
    }
    
    if (self.headerViewDataSource) {
        UIView *v = [self.headerViewDataSource view:header.customView forHeaderInSection:section];
        [header installCustomView:v];
        return header;
    }
    
    if(self.normalHeaderFillColor){
        header.normalFillColor = self.normalHeaderFillColor;
    }
    if (self.normalHeaderTextColor) {
        header.normalTextColor = self.normalHeaderTextColor;
    }
    if (self.selectedHeaderFillColor) {
        header.selectedFillColor = self.selectedHeaderFillColor;
    }
    if (self.selectedHeaderTextColor) {
        header.selectedTextColor = self.selectedHeaderTextColor;
    }
    
    
    header.headerText = [self.data[section] description];
    
    
    return header;
    //    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.cellDataSource) {
        return [self.cellDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId];
    
    cell.textLabel.text = [self.data[indexPath.section] descriptionForSecondaryObjects][indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    
    return cell;
    
    //    return nil;
}




#pragma mark - Clickable Header Delegate

-(void)didClickHeaderView:(ClickableHeaderView *)headerView{
    
    id <ExpandableObject> obj = self.data[headerView.section];
    
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (NSInteger i = 0; i < [obj countOfSecondaryObjects]; ++i) {
        NSIndexPath *idxPath = [NSIndexPath indexPathForRow:i inSection:headerView.section];
        [indexPaths addObject:idxPath];
    }
    if (![obj opened]) { //open
        [obj setOpened:YES];
        headerView.opened = YES;
        NSIndexPath *lastIndex = indexPaths.lastObject;
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
        
        CGRect rect = [self.tableView rectForRowAtIndexPath:lastIndex];
        if (!CGRectContainsRect(self.tableView.bounds, rect)) {
            
            [self.tableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        
        if (!_allowsMutipleSelection && _lastSelectedSection >= 0) {
            id <ExpandableObject> objToClose = self.data[_lastSelectedSection];
            [objToClose setOpened: NO];
            ClickableHeaderView *headerToClose = (ClickableHeaderView *)[self.tableView headerViewForSection:_lastSelectedSection];
            headerToClose.opened = NO;
            
            NSMutableArray *indexPathToClose = [NSMutableArray new];
            for (NSInteger j = 0; j < [objToClose countOfSecondaryObjects]; ++j) {
                NSIndexPath *idxPath = [NSIndexPath indexPathForRow:j inSection:_lastSelectedSection];
                [indexPathToClose addObject:idxPath];
            }
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:indexPathToClose withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
        }
        
        _lastSelectedSection = headerView.section;
        
    }else{
        [obj setOpened:NO];
        headerView.opened = NO;
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        _lastSelectedSection = -1;
    }
    
    if(self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(didSelectHeaderAnIndex:)]){
        [self.eventDelegate didSelectHeaderAnIndex:headerView.section];
    }
}


#pragma mark - Setters

-(void)setData:(NSArray<id<ExpandableObject>> *)data{
    
    if (!_allowsMutipleSelection && _lastSelectedSection >= 0) {
        id <ExpandableObject> objToClose = _data[_lastSelectedSection];
        [objToClose setOpened: NO];
    }
    
    _data = data;
    _lastSelectedSection = -1;
    if (self.tableView) {
        [self.tableView reloadData];
    }
}

-(void)setCellDataSource:(id<CustomCellDataSource>)cellDataSource{
    _cellDataSource = cellDataSource;
    if (self.tableView && _cellDataSource) {
        [_cellDataSource registerCellReuseIdForTableView:self.tableView];
    }
}

-(void)viewDidLayoutSubviews{
    self.tableView.frame = self.view.bounds;
}

@end
