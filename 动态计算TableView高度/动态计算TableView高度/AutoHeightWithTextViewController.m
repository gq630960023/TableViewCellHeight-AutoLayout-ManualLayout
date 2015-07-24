//
//  AutoHeightWithTextViewController.m
//  计算TableView高度
//
//  Created by yingying on 15/7/24.
//  Copyright (c) 2015年 yingying. All rights reserved.
//

#import "AutoHeightWithTextViewController.h"
#import "NSString+Kit.h"
#import "C5.h"


@interface AutoHeightWithTextViewController ()<UITextViewDelegate>

//TODO: 数据源修改为可变数组!!
@property (nonatomic, strong) NSMutableArray *tableData;//数据源
@property (nonatomic, strong) UITableViewCell *prototypeCell;//保存计算Cell高度的实例变量
@property (nonatomic, strong) NSString *updatedStr; //用来记录正在修改的TextView的内容

@end

@implementation AutoHeightWithTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //cell注册
    UINib *cellNib = [UINib nibWithNibName:@"C5" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"C5"];
    
    //数据源内容填充
    self.tableData = [[NSMutableArray alloc]initWithArray:@[@"1\n2\n3\n4\n5\n6", @"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"1"]];

    //初始化计算cell高度的实例变量
    self.prototypeCell  = [self.tableView dequeueReusableCellWithIdentifier:@"C5"];
    
    C5 *c = [[[NSBundle mainBundle] loadNibNamed:@"C5" owner:self options:nil] objectAtIndex:0];
    
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
    C5 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"C5"];
    cell.t.text = self.tableData[indexPath.row];
    cell.t.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    C5 *cell = (C5 *)self.prototypeCell;
    cell.t.text = self.tableData[indexPath.row];
    CGSize s =  [cell.t sizeThatFits:CGSizeMake(cell.t.frame.size.width, FLT_MAX)];
    CGFloat defaultHeight = cell.contentView.frame.size.height;
    CGFloat height = s.height > defaultHeight ? s.height : defaultHeight;
    return 1  + height;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        NSLog(@"h=%f", textView.contentSize.height);
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.updatedStr = textView.text;
    
    //因为当前我们可输入的cell为多个, 所以要遍历查看当前被修改的cell到底为哪一个.
    //可以通过其他方式来定位, 我能想到的: 1. tag 2.向上遍历 3. textView被修改在Cell中, 那就不需要遍历.(注意复用可能产生问题)
    C5 *cell = [self cellOfTextViewSuper:textView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    self.tableData[indexPath.row] = textView.text;

    
    //TODO: 界面更新这里, 根据监听, 我发现更新内容实际是全部列表 . 感觉会比较耗性能.
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
}


- (C5 *)cellOfTextViewSuper:(UITextView *)textView{
    for (UIView* next = [textView superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[C5 class]]) {
            return (C5 *)nextResponder;
        }
    }
    return nil;
}

@end
