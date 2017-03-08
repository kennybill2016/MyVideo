//
//  SaveObject.h
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/8.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveObject : NSObject

+ (instancetype)shared;

- (void)saveLoginPassword:(NSString *)pwd;

- (NSString *)readLoginPassword;

@end
