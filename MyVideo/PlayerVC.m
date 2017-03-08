//
//  PlayerVC.m
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/7.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//
/*
 AVPlayer 用于播放音视频
 AVPlayerItem 音频的对象
 AVPlayerLayer 播放显示视频的图层界面
 AVPlayerViewController 创建显示视频的图层，有调节控制控件
 */
#import "PlayerVC.h"
#import <AVFoundation/AVFoundation.h>

#import "ZFPlayer.h"
@interface PlayerVC ()<ZFPlayerDelegate>

@property (nonatomic,strong) ZFPlayerView *playerView;

@end

@implementation PlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.playerView = [[ZFPlayerView alloc] init];
    self.playerView.frame = self.view.bounds;
    [self.view addSubview:self.playerView];
    
    ///初始化控制层
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    ///初始化播放模型
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
    playerModel.title = @"第三方";
    playerModel.videoURL = [NSURL fileURLWithPath:self.resoucePath];
    playerModel.fatherView = self.view;
    [self.playerView playerControlView:controlView playerModel:playerModel];
    
    ///设置代理
    self.playerView.delegate = self;
    ///自动播放
    [self.playerView autoPlayTheVideo];
    
    // Do any additional setup after loading the view.
}
- (void)zf_playerBackAction{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
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
