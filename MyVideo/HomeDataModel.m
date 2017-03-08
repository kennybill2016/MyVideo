//
//  HomeDataModel.m
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/7.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "HomeDataModel.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#define FILEPATHS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
@interface HomeDataModel()


@end
@implementation HomeDataModel

- (NSMutableArray *)parseData{
    NSMutableArray *dataArr = [NSMutableArray array];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *tempFileList = [fileManager contentsOfDirectoryAtPath:FILEPATHS error:nil];
    for (NSString *pathStr in tempFileList) {
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",FILEPATHS,pathStr];
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:filePath error:nil];
        HomeDataModel *model = [[HomeDataModel alloc] init];
        model.resouceName = pathStr;
        model.resoucePath = filePath;
        model.resouceSize = [NSString stringWithFormat:@"%0.2f",[fileDic[@"NSFileSize"] integerValue]/1000.0/1024.0];
        [dataArr addObject:model];
    }
    return dataArr;
}
- (NSMutableArray *)getMovies{
    NSMutableArray *dataArr = [NSMutableArray array];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *tempFileList = [fileManager contentsOfDirectoryAtPath:FILEPATHS error:nil];
    for (NSString *pathStr in tempFileList) {
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",FILEPATHS,pathStr];
        if ([self isMovies:filePath]) {
            NSDictionary *fileDic = [fileManager attributesOfItemAtPath:filePath error:nil];
            HomeDataModel *model = [[HomeDataModel alloc] init];
            model.resouceName = pathStr;
            model.resoucePath = filePath;
            model.resouceSize = [NSString stringWithFormat:@"%0.2f",[fileDic[@"NSFileSize"] integerValue]/1000.0/1024.0];
            [dataArr addObject:model];
        }
    }
    return dataArr;
}
- (void)removeObject:(HomeDataModel *)model{
     NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:model.resoucePath error:nil];
}

///判断是不是视频文件
- (BOOL)isMovies:(NSString *)path{
    return [[[AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:path] options:nil] tracksWithMediaType:AVMediaTypeVideo] count] > 0;
}

///判断文件是否为video或者mp4(本地文件类型)
- (BOOL)isVideo:(NSString *)path{
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return NO;
    }
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
        return NO;
    }
    if ([(__bridge NSString *)(MIMEType) isEqualToString:@"video/mp4"]) {
        return YES;
    }
    return NO;
}
@end
