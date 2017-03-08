//
//  HomeTBVC.m
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/7.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "HomeTBVC.h"
#import <AVFoundation/AVFoundation.h>
@implementation HomeTBVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshData:(HomeDataModel *)model{
    self.movieImageVIew.image = [self getScreenShotImageFromMoviePath:model.resoucePath];
    self.movieTitleLabel.text = model.resouceName;
    self.movieSize.text = [model.resouceSize stringByAppendingString:@"M"];;
}
- (UIImage *)getScreenShotImageFromMoviePath:(NSString *)path{
    UIImage *shotImage;
    ///视频路径
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:fileURL options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    ///适用于首选跟踪变换
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(10, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    shotImage = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return shotImage;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
