//
//  DefaultCellAndHeaderViewController.m
//  CYExpandableTableView-master
//
//  Created by Gocy on 16/8/16.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#import "DefaultCellAndHeaderViewController.h"
#import "Parent.h"
#import "Child.h"
#import "CYExpandableTableViewController.h"

@interface DefaultCellAndHeaderViewController () <UITableViewDelegate>

@property (nonatomic ,strong) NSMutableArray *parents;
@property (nonatomic ,weak) UIView *tableView;

@end

@implementation DefaultCellAndHeaderViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Default";
    
    [self generateData];
    [self installTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Layout
-(void)viewDidLayoutSubviews{
    //if you use autolayout , you don't have to add this line of code.
    _tableView.frame = self.view.bounds;
}


#pragma mark - Helpers

- (void)installTableView{
    CYExpandableTableViewController *tbvc = [CYExpandableTableViewController new];
//    tbvc.selectedHeaderFillColor = [UIColor orangeColor];
    
    tbvc.tableViewDelegate = self;
    
    tbvc.data = [NSArray arrayWithArray:self.parents];;
    
    UIView *tableView = tbvc.view;
    
    [self.view addSubview:tableView];
    [self addChildViewController:tbvc];
    
    _tableView = tableView;
    
}

- (void)generateData{
    self.parents = [NSMutableArray new];
    
    NSArray *names = @[
                       @"Aaron",
                       @"Adam",
                       @"Frank",
                       @"Fallon",
                       @"Raymond",
                       @"John",
                       @"Harold",
                       @"Shaw",
                       @"Carter",
                       @"Fusco"
                       ];
    
    
    NSUInteger parentCount = arc4random() % 5 + 2; // at least 2
    
    for (NSUInteger i = 0; i < parentCount; ++i) {
        NSUInteger childCount = arc4random() % 6 + 1;
        NSMutableArray *children = [NSMutableArray new];
        for (NSUInteger j = 0; j < childCount; ++j) {
            Child *child = [Child new];
            NSUInteger random = arc4random() % names.count;
            child.name = names[random];
            child.age = random;
            child.gender = random % 2 ? @"boy" : @"girl";
            [children addObject:child];
        }
        Parent *parent = [Parent new];
        parent.name = names[arc4random() % names.count];
        parent.children = [NSArray arrayWithArray:children];
        [self.parents addObject:parent];
    }
    
}


#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"tableView did select , row : %lu , sec : %lu" ,indexPath.row,indexPath.section);
}

@end
