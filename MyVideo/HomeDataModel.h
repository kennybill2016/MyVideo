//
//  HomeDataModel.h
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/7.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeDataModel : NSObject

@property (nonatomic,copy) NSString *resouceName;

@property (nonatomic,copy) NSString *resoucePath;

@property (nonatomic,copy) NSString *resouceSize;

- (NSMutableArray *)parseData;

- (NSMutableArray *)getMovies;

- (void)removeObject:(HomeDataModel *)model;

@end
