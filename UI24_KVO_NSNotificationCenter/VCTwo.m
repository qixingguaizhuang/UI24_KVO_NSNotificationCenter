//
//  VCTwo.m
//  UI24_KVO_NSNotificationCenter
//
//  Created by dllo on 16/1/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "VCTwo.h"

@interface VCTwo ()
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@end

@implementation VCTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
}



- (IBAction)handleSave:(id)sender {
    
    // 获取到通知中心,然后向 "abc" 发送通知.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"abc" object:nil userInfo:@{@"content":self.textFieldName.text}];
    
    // 点击保存 回到上一个界面+
    [self.navigationController popViewControllerAnimated:YES];
    
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
