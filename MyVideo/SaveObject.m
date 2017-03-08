//
//  SaveObject.m
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/8.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "SaveObject.h"
#import "SFHFKeychainUtils.h"

#define SERVICE_NAME @"MyVideoKeyChainSaveToolByLiShuangshuai"

@implementation SaveObject

+ (instancetype)shared{
    static SaveObject *s_instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instace = [[SaveObject alloc] init];
    });
    return s_instace;
}

- (void)saveLoginPassword:(NSString *)pwd{
    [SFHFKeychainUtils storeUsername:@"LoginPassword" andPassword:pwd forServiceName:SERVICE_NAME updateExisting:1 error:nil];
}
- (NSString *)readLoginPassword{
    return [SFHFKeychainUtils getPasswordForUsername:@"LoginPassword"andServiceName:SERVICE_NAME error:nil];
}

@end
