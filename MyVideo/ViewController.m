//
//  ViewController.m
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/7.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "ViewController.h"

#define FILEPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface ViewController ()

@property (nonatomic,strong) NSFileManager *fileManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fileManager = [NSFileManager defaultManager];
    
    NSArray *tempFileList = [[NSArray alloc] initWithArray:[self.fileManager contentsOfDirectoryAtPath:FILEPATH error:nil]];
    NSLog(@"%@-----%@",FILEPATH,tempFileList);
    
    for (NSString *str in tempFileList) {
        NSDictionary *dic = [self.fileManager attributesOfItemAtPath:[NSString stringWithFormat:@"%@/%@",FILEPATH,str] error:nil];
        NSLog(@"%@",dic[@"NSFileSize"]);
    }
    
    
    
    
//    [self creatDirectoryNamed:@"视频"];
//    
//    [self creatDirectoryNamed:@"音乐"];
//    
//    [self creatDirectoryNamed:@"文档"];
    
    

}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

////创建文件夹
- (BOOL)creatDirectoryNamed:(NSString *)name{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",FILEPATH,name];
    if (![self.fileManager fileExistsAtPath:filePath]) {
       return [self.fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return YES;
}

////得到路径
-(NSString*)shareFilePath:(NSString*)filePath {
    
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent: filePath];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
