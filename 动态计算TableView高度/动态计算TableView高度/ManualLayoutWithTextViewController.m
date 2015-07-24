//
//  ManualLayoutWithTextViewController.m
//  动态计算TableView高度
//
//  Created by yingying on 15/7/23.
//  Copyright (c) 2015年 yingying. All rights reserved.
//

#import "ManualLayoutWithTextViewController.h"
#import "NSString+Kit.h"
#import "C4.h"

@interface ManualLayoutWithTextViewController ()

@property (nonatomic, strong) NSArray *tableData;//数据源
@property (nonatomic, strong) UITableViewCell *prototypeCell;//保存计算Cell高度的实例变量


@end

@implementation ManualLayoutWithTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //cell注册
    UINib *cellNib = [UINib nibWithNibName:@"C4" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"C4"];
    
    //数据源内容填充
    self.tableData = @[@"1\n2\n3\n4\n5\n6", @"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"1"];
    
    //初始化计算cell高度的实例变量
    self.prototypeCell  = [self.tableView dequeueReusableCellWithIdentifier:@"C4"];
    
    C4 *c = [[[NSBundle mainBundle] loadNibNamed:@"C4" owner:self options:nil] objectAtIndex:0];
    
    CGSize size = [c.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"h=%f", size.height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    C4 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"C4"];
    cell.t.text = [self.tableData objectAtIndex:indexPath.row];
    [cell.t sizeToFit];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    C4 *cell = (C4 *)self.prototypeCell;
    NSString *str = [self.tableData objectAtIndex:indexPath.row];
    cell.t.text = str;
    CGSize s =  [cell.t sizeThatFits:CGSizeMake(cell.t.frame.size.width, FLT_MAX)];
    CGFloat defaultHeight = cell.contentView.frame.size.height;
    CGFloat height = s.height > defaultHeight ? s.height : defaultHeight;
    return 1  + height;
}

@end
