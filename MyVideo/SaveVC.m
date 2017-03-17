//
//  SaveVC.m
//  MyVideo
//
//  Created by 我叫哀木涕 on 2017/3/17.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "SaveVC.h"

@interface SaveVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *countText;
@property (weak, nonatomic) IBOutlet UITextField *psdText;

@end

@implementation SaveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.countText.delegate = self;
    self.countText.returnKeyType = UIReturnKeyNext;
    self.psdText.delegate = self;
    self.psdText.returnKeyType = UIReturnKeyGo;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.countText becomeFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.countText) {
        [self.psdText becomeFirstResponder];
    }else{
        if (self.countText.text.length == 0 || self.psdText.text.length == 0) {
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showErrorWithStatus:@"输入不完整"];
            return NO;
        }else{
            [self saveOfoMessage];
        }
    }
    return YES;
}
- (void)saveOfoMessage{
    OfoMes *ofo = [OfoMes MR_createEntity];
    ofo.address = @"";
    ofo.count = self.countText.text;
    ofo.password = self.psdText.text;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    if (self.newOfo) {
        self.newOfo(ofo);
    }
    [self.navigationController popViewControllerAnimated:NO];
    
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
