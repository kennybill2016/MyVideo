//
//  OfoVC.m
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/17.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "OfoVC.h"
#import "SaveVC.h"


@interface OfoVC ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSMutableArray *resultArr;

@property (nonatomic,strong) UISearchController *searchController;






@end

@implementation OfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"ofo";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backLast)];
    leftItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNew)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.searchController.searchBar;
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.active) {
        return self.resultArr.count;
    }
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    OfoMes *mes = self.searchController.active?self.resultArr[indexPath.row]:self.dataArr[indexPath.row];
    cell.textLabel.text = mes.count;
    cell.detailTextLabel.text = [[mes.password stringByAppendingString:@"      "] stringByAppendingString:mes.address];;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.searchController.active) {
        self.navigationItem.title = [self.resultArr[indexPath.row] password];
        self.searchController.active = NO;
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchController.active) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.searchController.active) {
        OfoMes *mes = self.dataArr[indexPath.row];
        [mes MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [self.dataArr removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }

}
- (void)backLast{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)addNew{
    SaveVC *save = [[SaveVC alloc] init];
    
    save.newOfo = ^(OfoMes *mes){
        [self addNewOfo:mes.count address:mes.address password:mes.password];
    };
    [self.navigationController pushViewController:save animated:YES];
}
- (void)addNewOfo:(NSString *)count address:(NSString *)address password:(NSString *)pwd{
    OfoMes *mes = [OfoMes MR_createEntity];
    mes.address = address;
    mes.count = count;
    mes.password = pwd;
    [self.dataArr addObject:mes];
    [self.tableView reloadData];
}
#pragma mark - searchController -
- (UISearchController *)searchController{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.obscuresBackgroundDuringPresentation = NO;
        _searchController.disablesAutomaticKeyboardDismissal = NO;
        ///定义searchBar样式
        _searchController.searchBar.placeholder = @"请输入车号";
        _searchController.searchResultsUpdater = self;
    }
    return _searchController;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithArray:[OfoMes MR_findAll]];
    }
    return _dataArr;
}
#pragma mark - UISearchResultsUpdating -
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    ///得到输入文字
    NSString *text = searchController.searchBar.text;
    [self.resultArr removeAllObjects];
    [self.dataArr enumerateObjectsUsingBlock:^(OfoMes *obj, NSUInteger idx, BOOL * _Nonnull stop) {

        if (([obj.address rangeOfString:text].location != NSNotFound) || ([obj.count rangeOfString:text].location != NSNotFound) || ([obj.password rangeOfString:text].location != NSNotFound)) {
            [self.resultArr addObject:obj];
        }
    }];
    [self.tableView reloadData];

}
- (NSMutableArray *)resultArr{
    if (!_resultArr) {
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
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
