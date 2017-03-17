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
#import "SaveObject.h"
#import "OfoVC.h"
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

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftButton setBackgroundImage:[[UIImage imageNamed:@"LeftBarImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 35, 48);
    [leftButton addTarget:self action:@selector(setController) forControlEvents:UIControlEventTouchUpInside];
    [leftButton addTarget:self action:@selector(ofoVC) forControlEvents:UIControlEventTouchDragExit];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    self.dataArr = [NSMutableArray array];
    
    self.dataModel = [[HomeDataModel alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
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
    if ([[SaveObject shared] readLoginPassword]) {
        [[SaveObject shared] removeLoginPassword];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showSuccessWithStatus:@"密码已清除"];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设置启动密码并启用TouchID" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入启动密码";
            textField.secureTextEntry = YES;
        }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请再次启动密码";
            textField.secureTextEntry = YES;
        }];
        UIAlertAction *setction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([alert.textFields.firstObject.text isEqualToString:alert.textFields.lastObject.text]) {
                [[SaveObject shared] saveLoginPassword:alert.textFields.firstObject.text];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                [SVProgressHUD showSuccessWithStatus:@"设置成功"];
            }else{
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                [SVProgressHUD showErrorWithStatus:@"设置失败，两次密码不一致"];
            }
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:setction];
        [alert addAction:cancleAction];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }

}

- (void)pushNextVC:(UIViewController *)VC{
    [self.navigationController pushViewController:VC animated:NO];
}
- (void)ofoVC{
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[OfoVC alloc] init]] animated:YES completion:^{
        
    }];
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
