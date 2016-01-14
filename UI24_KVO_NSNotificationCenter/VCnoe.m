//
//  VCnoe.m
//  UI24_KVO_NSNotificationCenter
//
//  Created by dllo on 16/1/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "VCnoe.h"

@interface VCnoe ()
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@end

@implementation VCnoe


- (void)dealloc{
    
    //从通知中心中移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"abc" object:nil];

}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"abc" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
    self.labelName.text = [note.userInfo objectForKey:@"content"];
        
       //NSLog(@"%@",note);
        
    }];
    
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
