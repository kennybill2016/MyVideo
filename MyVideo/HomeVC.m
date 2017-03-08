//
//  HomeVC.m
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/7.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "HomeVC.h"
#import "Masonry.h"
#import "HomeTBVC.h"
#import "HomeDelegate.h"
#import "HomeDataModel.h"
#import "HomeDataSouce.h"
#import "SVProgressHUD.h"
#define FILEPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
@interface HomeVC ()<DeleDelegate,DataDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) HomeDelegate *delegateHome;

@property (nonatomic,strong) HomeDataSouce *dataSouceHome;

@property (nonatomic,strong) HomeDataModel *dataModel;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"视频列表";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshTableView)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"LeftBarImage"] style:UIBarButtonItemStylePlain target:self action:@selector(setController)];
    leftItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    self.dataArr = [NSMutableArray array];
    
    self.dataModel = [[HomeDataModel alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTBVC" bundle:nil] forCellReuseIdentifier:@"cellId"];
    
    self.delegateHome = [[HomeDelegate alloc] init];
    self.delegateHome.delegate = self;
    self.tableView.delegate = self.delegateHome;
    
    self.dataSouceHome = [[HomeDataSouce alloc] init];
    self.dataSouceHome.delegate = self;
    self.tableView.dataSource = self.dataSouceHome;
    
    [self.view addSubview:self.tableView];
    
    [self layoutSubView];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self refreshTableView];
}
- (void)layoutSubView{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}
- (void)refreshTableView{
    self.dataArr = [self.dataModel getMovies];
    self.delegateHome.dataArr = self.dataArr;
    self.dataSouceHome.dataArr = self.dataArr;
    [self.tableView reloadData];
}
- (void)setController{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设置启动密码并启用TouchID" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入启动密码";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请再次启动密码";
    }];
    UIAlertAction *setction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([alert.textFields.firstObject.text isEqualToString:alert.textFields.lastObject.text]) {
            [SVProgressHUD showSuccessWithStatus:@"设置成功"];
        }
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:setction];
    [alert addAction:cancleAction];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)pushNextVC:(UIViewController *)VC{
    [self.navigationController pushViewController:VC animated:NO];
}
- (void)deleCell:(NSIndexPath *)indexPath{
    [self.dataModel removeObject:self.dataArr[indexPath.row]];
    [self.dataArr removeObjectAtIndex:indexPath.row];
    self.delegateHome.dataArr = self.dataArr;
    self.dataSouceHome.dataArr = self.dataArr;
    [self.tableView reloadData];
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

@end
