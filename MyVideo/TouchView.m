//
//  TouchView.m
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/7.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "TouchView.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "SaveObject.h"
@interface TouchView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *oneLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourLabel;

@property (weak, nonatomic) IBOutlet UILabel *warmLabel;
@property (weak, nonatomic) IBOutlet UITextField *inPutTextField;



@end
@implementation TouchView
- (instancetype)init{
    self = [[NSBundle mainBundle] loadNibNamed:@"TouchView" owner:self options:nil].firstObject;
    if (self) {
        
//        self.oneLabel.layer.cornerRadius = 5.0;
//        self.oneLabel.layer.borderWidth = 1.0;
//        self.oneLabel.layer.borderColor = [UIColor grayColor].CGColor;
//        self.oneLabel.clipsToBounds = YES;
//        
//        
//        self.twoLabel.layer.cornerRadius = 5.0;
//        self.twoLabel.layer.borderWidth = 1.0;
//        self.twoLabel.layer.borderColor = [UIColor grayColor].CGColor;
//        self.twoLabel.clipsToBounds = YES;
//        
//        self.threeLabel.layer.cornerRadius = 5.0;
//        self.threeLabel.layer.borderWidth = 1.0;
//        self.threeLabel.layer.borderColor = [UIColor grayColor].CGColor;
//        self.threeLabel.clipsToBounds = YES;
//        
//        self.fourLabel.layer.cornerRadius = 5.0;
//        self.fourLabel.layer.borderWidth = 1.0;
//        self.fourLabel.layer.borderColor = [UIColor grayColor].CGColor;
//        self.fourLabel.clipsToBounds = YES;
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = [UIColor orangeColor];
        
        self.inPutTextField.delegate =  self;
        
        [self touchBegin];
        
    }
    return self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self sureButton:nil];
    return YES;
}

- (IBAction)sureButton:(id)sender {
    
    if ([self.inPutTextField.text isEqualToString:[[SaveObject shared] readLoginPassword]]) {
        [self removeFromSuperview];
    }else{
        self.warmLabel.text = @"密码输入错误，请重新输入";
    }
    
}
- (IBAction)touchIDButton:(id)sender {
    [self touchBegin];
}

- (void)touchBegin{
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
        LAContext *context = [[LAContext alloc] init];
        context.localizedCancelTitle = @"取消";
        NSError *error = nil;
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"通过home验证有指纹" reply:^(BOOL success, NSError * _Nullable error) {
                
                if (success) {
                    NSLog(@"TouchID 验证成功");
                    [self removeFromSuperview];
                }else if (error){
                    
                    switch (error.code) {
                        case LAErrorAuthenticationFailed:{
                            self.warmLabel.text = @"验证失败";
                            NSLog(@"验证失败");
                        }
                            
                            break;
                        case LAErrorUserCancel:
                        {NSLog(@"手动取消");
                            self.warmLabel.text = @"手动取消";
                        }
                            
                            break;
                        case LAErrorUserFallback:{NSLog(@"输入密码");
                            self.warmLabel.text = @"输入密码";
                        }
                            
                            break;
                        case LAErrorSystemCancel:{NSLog(@"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)");
                            self.warmLabel.text = @"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)";
                        }
                            
                            break;
                        case LAErrorPasscodeNotSet:{NSLog(@"无法启动，没有设置密码");
                            self.warmLabel.text = @"无法启动，没有设置密码";
                        }
                            
                            break;
                        case LAErrorTouchIDNotEnrolled:{NSLog(@"无法启动，没有设置touchID");
                            self.warmLabel.text = @"无法启动，没有设置touchID";
                        }
                            
                            break;
                        case LAErrorTouchIDNotAvailable:{NSLog(@"TouchID无效");
                            self.warmLabel.text = @"TouchID无效";
                        }
                            
                            break;
                        case LAErrorTouchIDLockout:{NSLog(@"多次使用无效，被锁定");
                            self.warmLabel.text = @"多次使用无效，被锁定";
                        }
                            
                            break;
                        case LAErrorAppCancel:{NSLog(@"软件被挂起，比如进入后台");
                            self.warmLabel.text = @"软件被挂起，比如进入后台";
                        }
                            
                            break;
                        case LAErrorInvalidContext:{NSLog(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                            self.warmLabel.text = @"当前软件被挂起并取消了授权 (LAContext对象无效)";
                        }
                            
                            break;
                        default:
                            break;
                    }
                }
            }];
        }
    }else{
        self.warmLabel.text = @"当前设备不支持指纹解锁";
        [self.inPutTextField becomeFirstResponder];
        NSLog(@"当前设备不知道吃touchId");
    }
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
