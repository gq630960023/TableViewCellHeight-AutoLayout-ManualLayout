//
//  AutoLayoutWithTextViewController.m
//  动态计算TableView高度
//
//  Created by yingying on 15/7/23.
//  Copyright (c) 2015年 yingying. All rights reserved.
//

#import "AutoLayoutWithTextViewController.h"
#import "C2.h"

@interface AutoLayoutWithTextViewController ()

@property (nonatomic, strong) NSArray *tableData;//数据源
@property (nonatomic, strong) UITableViewCell *prototypeCell;//保存计算Cell高度的实例变量

@end

@implementation AutoLayoutWithTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //cell注册
    UINib *cellNib = [UINib nibWithNibName:@"C2" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"C2"];
    
    //数据源内容填充
    self.tableData = @[@"1\n2\n3\n4\n5\n6", @"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"1"];
    
    //初始化计算cell高度的实例变量
    self.prototypeCell  = [self.tableView dequeueReusableCellWithIdentifier:@"C2"];
    
    C2 *c = [[[NSBundle mainBundle] loadNibNamed:@"C2" owner:self options:nil] objectAtIndex:0];
    
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
    C2 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"C2"];
    cell.t.text = [self.tableData objectAtIndex:indexPath.row];
    return cell;
}

//包含textView的cell在计算高度的时候, 要单独考虑textview的高度.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    C2 *cell = (C2 *)self.prototypeCell;
    cell.t.text = [self.tableData objectAtIndex:indexPath.row];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGSize textViewSize = [cell.t sizeThatFits:CGSizeMake(cell.t.frame.size.width, FLT_MAX)];
    CGFloat h = size.height + textViewSize.height;
    h = h > 10 ? h : 10;  //89是图片显示的最低高度， 见xib
    NSLog(@"h=%f", h);
    return 1 + h;
}
@end
