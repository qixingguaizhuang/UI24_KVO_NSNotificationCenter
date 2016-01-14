//
//  CellForExtend.m
//  UI24_KVO_NSNotificationCenter
//
//  Created by dllo on 16/1/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "CellForExtend.h"

@interface CellForExtend ()

@property (weak, nonatomic) IBOutlet UIButton *buttonForDele;
@property (weak, nonatomic) IBOutlet UILabel *labelForName;


@end

@implementation CellForExtend

- (void)awakeFromNib {
    // 圆角
    
    self.labelForName.layer.cornerRadius = 5;
    self.labelForName.layer.masksToBounds = YES;
    
    //删除 button 隐藏
    self.buttonForDele.hidden = YES;
    
    //注册一个通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleShowDele:) name:@"showDele" object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showComplete:) name:@"complete" object:nil];
 
}

- (void)handleShowDele:(NSNotification *)noti{

    // 显示 button
    self.buttonForDele.hidden = NO;
}



- (void)showComplete:(NSNotification *)noti{
    
    self.buttonForDele.hidden = YES;

}










@end
