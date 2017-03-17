//
//  SaveVC.h
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/17.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^addNewOfo)(OfoMes *mes);

@interface SaveVC : UIViewController

@property (nonatomic,copy) addNewOfo newOfo;

@end
