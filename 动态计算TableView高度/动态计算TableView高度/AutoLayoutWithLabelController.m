//
//  AutoLayoutWithLabelController.m
//  动态计算TableView高度
//
//  Created by yingying on 15/7/23.
//  Copyright (c) 2015年 yingying. All rights reserved.
//

#import "AutoLayoutWithLabelController.h"
#import "C1TableViewCell.h"

@interface AutoLayoutWithLabelController ()

@property (nonatomic, strong) NSArray *tableData;//数据源
@property (nonatomic, strong) UITableViewCell *prototypeCell;//保存计算Cell高度的实例变量

@end

@implementation AutoLayoutWithLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //cell注册
    UINib *cellNib = [UINib nibWithNibName:@"C1TableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"C1TableViewCell"];
    
    //数据源内容填充
    self.tableData = @[@"1\n2\n3\n4\n5\n6", @"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"1"];
    
    //初始化计算cell高度的实例变量
    self.prototypeCell  = [self.tableView dequeueReusableCellWithIdentifier:@"C1TableViewCell"];
    
    C1TableViewCell *c = [[[NSBundle mainBundle] loadNibNamed:@"C1TableViewCell" owner:self options:nil] objectAtIndex:0];
    
    CGSize size = [c.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"h=%f", size.height);

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    C1TableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"C1TableViewCell"];
    cell.t.text = [self.tableData objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    C1TableViewCell *cell = (C1TableViewCell *)self.prototypeCell;
    //translatesAutoresizingMaskIntoConstraints 用来禁止AutoresizingMask转换成AutoLayout,简单来说,Autoresizing和AutoLayout用的不是一套东西,但是默认情况下是相互转换的,这里我们要指定使用AutoLayout系统,所以要禁止自动转换
    cell.translatesAutoresizingMaskIntoConstraints = NO;
    cell.t.translatesAutoresizingMaskIntoConstraints = NO;
    cell.i.translatesAutoresizingMaskIntoConstraints = NO;
    cell.t.text = [self.tableData objectAtIndex:indexPath.row];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"h=%f", size.height + 1);
    return 1  + size.height;
}

//为cell提供一个预估的高度, 用来提高性能
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 66;
//}
@end
