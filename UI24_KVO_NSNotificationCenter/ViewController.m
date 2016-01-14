//
//  ViewController.m
//  UI24_KVO_NSNotificationCenter
//
//  Created by dllo on 16/1/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ViewController.h"
#import "CellForExtend.h"

#define WIDTH  self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface ViewController ()<UICollectionViewDataSource ,UICollectionViewDelegate>

@property (nonatomic, retain)UICollectionView  *collectView;
@property (nonatomic, retain)UIView *viewForRedLine;
@property (nonatomic, retain)UIButton *buttonForExtension;
@property (nonatomic, retain)UIButton *buttonForComplete;
@property (nonatomic, retain)UICollectionView *collectExten;
@property (nonatomic, retain)NSMutableArray *arr;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createButton];
    [self createRedLine];
    [self createCollectView];
    [self creatKVOAction];
}

#pragma mark -- SubViews ( 红线, collectionview)

- (void)createRedLine{
    
    self.viewForRedLine = [[UIView alloc]initWithFrame:CGRectMake(0, 50, (self.view.frame.size.width/5), 2)];
    self.viewForRedLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.viewForRedLine];

}

#pragma mark -- collectionView

- (void)createCollectView{
    
    /** view 背景颜色*/
    self.view.backgroundColor = [UIColor redColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50 + 2, WIDTH, HEIGHT - 50 - 2) collectionViewLayout:flowLayout];
    
    flowLayout.itemSize = CGSizeMake(WIDTH, HEIGHT - 52);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
    [self.view addSubview:self.collectView];
    
     self.collectView.dataSource = self;
     self.collectView.delegate = self;
    
    /** 翻页效果 */
    self.collectView.pagingEnabled = YES;
    
    /** 滑动条显隐 */
     self.collectView.showsVerticalScrollIndicator = NO;
     self.collectView.backgroundColor = [UIColor whiteColor];
    
    [self.collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"pool"];
    [self.collectExten registerNib:[UINib nibWithNibName:@"CellForExtend" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"poolForCellExten"];

}

#pragma mark -- Button 创建 button

- (void)createButton{
    
     self.buttonForExtension = [UIButton buttonWithType:UIButtonTypeCustom];
     self.buttonForExtension.frame = CGRectMake(WIDTH - 50, 20, 30, 30);
    [self.buttonForExtension setImage:[UIImage imageNamed:@"j"] forState:UIControlStateNormal];
    [self.buttonForExtension addTarget:self action:@selector(handleExten:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.buttonForExtension];
    
}

/** 实现 button 的方法, 并创建 collectionView */
- (void)handleExten:(UIButton *)button {
    /**/
    button.selected = !button.selected;
    if (button.isSelected) {
        
        // 如果 collectionView 为空,没有创建,将进行创建
        if (!self.collectExten) { // !self.collectExten == ( self.collectExten == nil;)

        // 弹出一个collectView
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            
            layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
            layout.itemSize = CGSizeMake(65, 30);
            
            
            self.collectExten = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, 0) collectionViewLayout:layout] ;
            
            self.collectExten.backgroundColor = [UIColor whiteColor];
            
            [self.view addSubview:self.collectExten];
            
            self.collectExten.delegate = self;
            self.collectExten.dataSource = self;
            
            
#pragma mark 实现删除方法 
            
//            
////            [NSNotificationCenter defaultCenter] addObserverForName:<#(nullable NSString *)#> object:<#(nullable id)#> queue:<#(nullable NSOperationQueue *)#> usingBlock:<#^(NSNotification * _Nonnull note)block#>
//            
//            
//             [NSNotificationCenter defaultCenter] addObserver:<#(nonnull id)#> selector:<#(nonnull SEL)#> name:<#(nullable NSString *)#> object:<#(nullable id)#>
//            
//            
//            
//            
            
            
            
            
            
            // 添加手势
            
            [self addLongPress];
            
            // 注册
            
            [self.collectExten registerNib:[UINib nibWithNibName:@"CellForExtend" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"poolForCellExten"];
           
        }
        // 动画展开. 如果写入到上面创建 collectionView 中收回后,将无法调出下来 collectionView
        
        [UIView animateWithDuration:0.5 animations:^{
            self.collectExten.frame = CGRectMake(0, 50, WIDTH, HEIGHT  / 4 );
            button.transform = CGAffineTransformMakeRotation(M_PI_2);
        }];
        
        
    }
    
    else {
            [UIView animateWithDuration:0.5 animations:^{
            self.collectExten.frame = CGRectMake(0, 50, WIDTH, 0);
            button.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}




#pragma mark -- 长按手势


- (void)addLongPress{

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    
    [self.collectExten addGestureRecognizer:longPress];
    

}

// 按成按钮

- (void)createbuttonForComplete{
     self.buttonForComplete = [UIButton buttonWithType:UIButtonTypeSystem];
     self.buttonForComplete.frame = CGRectMake(WIDTH - 60, 20, 50, 30);
     self.buttonForComplete.backgroundColor = [UIColor redColor];
     self.buttonForComplete.tintColor = [UIColor whiteColor];
    [self.buttonForComplete setTitle:@"完成" forState:UIControlStateNormal];
    [self.buttonForComplete addTarget:self action:@selector(CompleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonForComplete];

}

- (void)CompleteAction:(UIButton *) button{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"complete" object:nil userInfo:nil];
    self.buttonForComplete.hidden = YES;

}



- (void)handleLongPress:(UILongPressGestureRecognizer *)longpress{

    switch (longpress.state) {
        case UIGestureRecognizerStateBegan:
            
        {
            //通知中心
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showDele" object:nil userInfo:nil];
            
            NSIndexPath *beginIndexPath = [self.collectExten indexPathForItemAtPoint:[longpress locationInView:self.collectExten]];
            
            if (beginIndexPath == nil) {
                return;
            }
            
            // 完成按钮弹出
            [self createbuttonForComplete];
            
            [self.collectExten beginInteractiveMovementForItemAtIndexPath:beginIndexPath];
            
            

            break;
        }
            case UIGestureRecognizerStateChanged:
        {
            [self.collectExten updateInteractiveMovementTargetPosition:[longpress locationInView:self.collectExten]];
            break;
        }
            
            case UIGestureRecognizerStateEnded:
        {
            [self.collectExten endInteractiveMovement];
            break;
            
        }
        default:
            [self.collectExten cancelInteractiveMovement];
            break;
    }
}


/** Item 移动 **/
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
    
}

/** 移动后,数据进行更新 */
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    
}




#pragma mark --- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == self.collectView) {
        return 5;
    }else{
        return 10;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
  
    if (collectionView == self.collectView) {
       
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pool" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.f green:arc4random() % 256 / 255.f blue:arc4random() % 256 / 255.f alpha:1.f];
        return cell;
        
    }else {
        
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"poolForCellExten" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    }
}


#pragma mark -- 知识点 1 KVO 键值观察者

/* 核心:观察者观察某一个对象的属性, 变化 */

- (void)creatKVOAction{
    
    // VC 观察 collection 的 contentOffset 属性. forKeyPath 监察属性这里检查 偏移量
    [self.collectView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"context"];

}

// 当被观察值属性发生变化的时候,调用此方法

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    
    CGFloat x =  [[change objectForKey:@"new"] CGPointValue].x; // news 通过打印change 看出
    CGFloat redX = x/5; // x *width / 5 /width;
    
    //修改 redline  位置
    
    self.viewForRedLine.transform = CGAffineTransformMakeTranslation(redX, 0);

    NSLog(@"%@", change);
//    NSLog(@"%f", x);

}



#pragma  mark --知识点 2 通知中心详见后面两个 VC












#pragma mark
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
