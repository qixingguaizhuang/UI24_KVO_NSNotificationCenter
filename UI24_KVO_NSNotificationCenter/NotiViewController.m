//
//  NotiViewController.m
//  UI24_KVO_NSNotificationCenter
//
//  Created by dllo on 16/1/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "NotiViewController.h"
#define WIDTH  self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface NotiViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;


@end

@implementation NotiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.button.layer.cornerRadius = 10;
    [self Noficenter];
    
}



#pragma mark - 通知中心 系统中已经存在

- (void)Noficenter{

//获取通知中心对象
    
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(handleNofi:) name:
     UIKeyboardWillShowNotification object:nil];
    
    // 键盘将要隐藏时调用
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
       
        // 更改 self.view 的 frame
        
        self.view.frame  = CGRectMake(0, 0 ,WIDTH , HEIGHT);
        
       // NSLog(@"note: %@", note);

        
    }];
}


- (void)handleNofi:(NSNotification *)nofi{

    NSLog(@"%@", nofi);
   
    // 键盘高度.
    
    CGFloat height =  [[nofi.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue].size.height;
    
     // self.view 的 fram 发生改变.
    
    self.view.frame  = CGRectMake(0, -height ,WIDTH , HEIGHT);

}


- (IBAction)handleCom:(id)sender {
    
    [self.view endEditing:YES];
    
    
}










#pragma mark _____


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
