//
//  ViewController.m
//  TableViewHeaderScale
//
//  Created by Xinfeng Du on 2019/3/15.
//  Copyright © 2019 XXB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *expandImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = 49;
    [self.view addSubview:self.tableView];
    
    UIView *tableHeaderView = [[UIView alloc] init];
    tableHeaderView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    tableHeaderView.backgroundColor = [UIColor clearColor];
    
    self.expandImageView = [[UIImageView alloc] init];
    self.expandImageView.image = [UIImage imageNamed:@"header"];
    self.expandImageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 176);
    [tableHeaderView addSubview:self.expandImageView];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, 65)];
    [path addLineToPoint:CGPointMake(self.view.bounds.size.width, 65)];
    [path addLineToPoint:CGPointMake(self.view.bounds.size.width, 0)];
    [path addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:CGPointMake(self.view.bounds.size.width/2, 65)];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor groupTableViewBackgroundColor].CGColor;
    layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    layer.borderWidth = 0;
    layer.frame = CGRectMake(0, 50 + 65, self.view.bounds.size.width, 65 + 20);
    [tableHeaderView.layer addSublayer:layer];
    
    
    UILabel *userInfoView = [[UILabel alloc] init];
    userInfoView.backgroundColor = [UIColor whiteColor];
    userInfoView.textAlignment = NSTextAlignmentCenter;
    userInfoView.text = @"用户信息";
    userInfoView.layer.cornerRadius = 10;
    userInfoView.layer.masksToBounds = YES;
    userInfoView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.04].CGColor;
    userInfoView.layer.shadowOffset = CGSizeMake(0,4);
    userInfoView.layer.shadowOpacity = 1;
    userInfoView.layer.shadowRadius = 12;
    userInfoView.frame = CGRectMake(20, 50, self.view.bounds.size.width-40, 130);
    [tableHeaderView addSubview:userInfoView];
    
    self.tableView.tableHeaderView = tableHeaderView;

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    CGFloat scale = 1.0;
    
    CGRect frame = self.expandImageView.frame;
    if (offsetY < 0) { // 下拉
        scale = 1 + ABS(offsetY) / 180;
        self.expandImageView.transform = CGAffineTransformMakeScale(scale, scale);
        frame = self.expandImageView.frame;
        frame.origin.y = offsetY;
        self.expandImageView.frame = frame;
    }else{ // 上拉
        self.expandImageView.frame = CGRectMake(0, -offsetY, self.view.bounds.size.width, 176);
    }
    
    NSLog(@"--->%f",offsetY);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellWithIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellWithIdentifier"];
    }    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = @"伊呀呀呀呀呀呀呀呀呀";
    return cell;
}


@end
