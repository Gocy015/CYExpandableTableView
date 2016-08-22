//
//  CustomCellAndHeaderViewController.m
//  CYExpandableTableView-master
//
//  Created by Gocy on 16/8/16.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#import "CustomCellAndHeaderViewController.h"
#import "CustomExpandableViewProtocol.h"
#import "CustomHeader.h"
#import "CYExpandableTableViewController.h"

#import "Poster.h"
#import "Detail.h"

#import "UIImage+Crop.h"

#import "Masonry.h"

#define RANDOM_COLOR() \
[UIColor colorWithRed:(arc4random() % 255 / 255.0) green:(arc4random() % 255 / 255.0) blue:(arc4random() % 255 / 255.0) alpha:1]

@interface CustomCellAndHeaderViewController () <CustomHeaderViewDataSource ,CustomCellDataSource ,ExpandableTableViewEventDelegate>

@property (nonatomic ,weak) UIView *tableView;
@property (nonatomic ,strong) NSMutableArray *posters;

@end

static NSString * const cellReuseId = @"CustomeCell";

@implementation CustomCellAndHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self generateData];
    [self installTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Helpers

- (void)installTableView{
    CYExpandableTableViewController *tbvc = [CYExpandableTableViewController new];
    //    tbvc.selectedHeaderFillColor = [UIColor orangeColor];
    
//    tbvc.tableViewDelegate = self;
    
//    tbvc.data = [NSArray arrayWithArray:self.parents];
    
    UIView *tableView = tbvc.view;
    
//    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    tbvc.headerViewDataSource = self;
    tbvc.cellDataSource = self;
    tbvc.eventDelegate = self;
    
    tbvc.headerSeperatorColor = [UIColor whiteColor];
    tbvc.headerSeperatorHeight = 12;
    
    [self.view addSubview:tableView];
    [self addChildViewController:tbvc];
    
    tbvc.data = [NSArray arrayWithArray:self.posters];
    
    _tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}
- (void)generateData{
    self.posters = [NSMutableArray new];
    
    
    
    Poster *batman = [Poster new];
    batman.imageUrl = @"Bat_Header";
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 1; i <= 3; ++i) {
        Detail *d = [Detail new];
        d.imageUrl = [NSString stringWithFormat:@"Bat_%i",i];
        [arr addObject:d];
    }
    batman.details = [NSArray arrayWithArray:arr];
    
    Poster *superman = [Poster new];
    superman.imageUrl = @"Superman_Header";
    [arr removeAllObjects];
    for (int i = 1; i <= 2; ++i) {
        Detail *d = [Detail new];
        d.imageUrl = [NSString stringWithFormat:@"Superman_%i",i];
        [arr addObject:d];
    }
    superman.details = [NSArray arrayWithArray:arr];
    
    [self.posters addObjectsFromArray:@[batman,superman]];
    
    
}


#pragma mark - Custom Header View DataSource
-(CGFloat)heightForHeaderViewInSection:(NSUInteger)section{
    return 70;
}

-(UIView *)view:(UIView *)view forHeaderInSection:(NSUInteger)section{
    CustomHeader *v = nil;
    if (!view) {
        v = [[CustomHeader alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70)];
    }else{
        v = (CustomHeader *)view;
    }
    
    Poster *poster = self.posters[section];
    
    UIImage *headerImage = [UIImage imageNamed:poster.imageUrl];
    v.contentMode = UIViewContentModeScaleToFill;
    CGSize imgSize = headerImage.size;
    v.image = [headerImage cropImageInRect:CGRectMake((imgSize.width - self.view.bounds.size.width)/2, 15, self.view.bounds.size.width, 70)];
    
    return v;
}


#pragma mark - Custom Cell Delegate

-(CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath{
    Poster *poster = self.posters[indexPath.section];
    Detail *detail = poster.details[indexPath.row];
    
    UIImage *detailImg = [UIImage imageNamed:detail.imageUrl];
    
    CGFloat height = detailImg.size.height / (detailImg.size.width / self.view.bounds.size.width);
    detail.img = [detailImg cropImageInRect:CGRectMake((detailImg.size.width - self.view.bounds.size.width)/2, 0, self.view.bounds.size.width, height)];
    
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId];
    
    UIImageView *imgView = [cell viewWithTag:22];
    if (!imgView) {
        imgView = [UIImageView new];
        imgView.tag = 22;
        [cell addSubview:imgView];
    }
    
    Poster *poster = self.posters[indexPath.section];
    Detail *detail = poster.details[indexPath.row];
    
    //detail img is pre-loaded in heightForCell
    imgView.frame = CGRectMake(0, 0, detail.img.size.width, detail.img.size.height);
    imgView.image = detail.img;
    
    
    return cell;
}

-(void)registerCellReuseIdForTableView:(UITableView *)tableView{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseId];
}


#pragma mark - ExpandableTableView Event Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"tableView did select , row : %li , sec : %li",indexPath.row,indexPath.section);
}

-(void)didSelectHeaderAnIndex:(NSUInteger)index{
    NSLog(@"tableView did select header at index : %lu",index);
}

@end
