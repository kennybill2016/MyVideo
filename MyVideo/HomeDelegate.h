//
//  HomeDelegate.h
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/7.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol DeleDelegate<NSObject>

- (void)pushNextVC:(UIViewController *)VC;


@end
@interface HomeDelegate : NSObject<UITableViewDelegate>

@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,weak) id<DeleDelegate> delegate;

@end
