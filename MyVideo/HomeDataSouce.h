//
//  HomeDataSouce.h
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/7.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol DataDelegate<NSObject>
@required
- (void)deleCell:(NSIndexPath *)indexPath;

@end
@interface HomeDataSouce : NSObject<UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,weak) id<DataDelegate> delegate;

@end
