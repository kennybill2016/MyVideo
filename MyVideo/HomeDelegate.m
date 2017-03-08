//
//  HomeDelegate.m
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/7.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "HomeDelegate.h"
#import "HomeDataModel.h"
#import "PlayerVC.h"

@implementation HomeDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlayerVC *player = [[PlayerVC alloc] init];
    player.resoucePath = [self.dataArr[indexPath.row] resoucePath];
    player.resouceName = [self.dataArr[indexPath.row] resouceName];
    if ([self.delegate respondsToSelector:@selector(pushNextVC:)]) {
        [self.delegate pushNextVC:player];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
@end
