//
//  HomeTBVC.h
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/7.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDataModel.h"
@interface HomeTBVC : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *movieImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieSize;

- (void)refreshData:(HomeDataModel *)model;

@end
