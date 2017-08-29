//
//  ViewController.m
//  TakeDownPhotoBigger
//
//  Created by 喻永权 on 2017/8/29.
//  Copyright © 2017年 喻永权. All rights reserved.
//

#import "ViewController.h"

#define  IMAGEHEIGHT 200

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, strong) UIVisualEffectView *effectView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.photoImageView];
    [self.tableView addSubview:self.effectView];
}

- (UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds  style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(IMAGEHEIGHT, 0, 0, 0);
    }
    return _tableView;
}

- (UIImageView *)photoImageView{
    if(_photoImageView == nil){
        _photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -IMAGEHEIGHT, CGRectGetWidth(self.view.frame), IMAGEHEIGHT)];
        _photoImageView.image = [UIImage imageNamed:@"photo.jpg"];
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _photoImageView.clipsToBounds = YES;
    }
    return _photoImageView;
}

- (UIVisualEffectView *)effectView{
    if(_effectView == nil){
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
        [_effectView setFrame:CGRectMake(0, -IMAGEHEIGHT, CGRectGetWidth(self.view.frame), IMAGEHEIGHT)];
    }
    return _effectView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndifier = @"tableviewCellIndifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndifier];
    }
    cell.textLabel.text =[NSString stringWithFormat:@"下拉照片放大 %d",(int)indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    CGFloat off_Y = scrollView.contentOffset.y;
    CGFloat KHeight = CGRectGetHeight(self.view.frame);
    
    if(off_Y < -IMAGEHEIGHT){
//        CGRect frame = self.photoImageView.frame;
        self.photoImageView.frame = CGRectMake(0, off_Y, CGRectGetWidth(self.view.frame), -off_Y);
        self.effectView.frame = self.photoImageView.frame;
        
        self.effectView.alpha = 1 + (off_Y + IMAGEHEIGHT) / KHeight;
    }
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
