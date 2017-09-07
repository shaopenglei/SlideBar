//
//  ViewController.m
//  SlideBar
//
//  Created by 邵朋磊 on 2017/8/24.
//  Copyright © 2017年 邵朋磊. All rights reserved.
//

#import "ViewController.h"
#import "SEFilterControl.h"

@interface ViewController ()
@property (nonatomic,strong)SEFilterControl *filter;
@property (nonatomic,strong)SEFilterControl *filter2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(25, 250, self.view.frame.size.width-50, 15) Titles:[NSArray arrayWithObjects:@"50000", @"100000" , @"100000", nil]];
    [_filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventTouchUpInside];
//    [_filter setAnimation:YES];
    [_filter setProgressColor:[UIColor groupTableViewBackgroundColor]];//设置滑杆的颜色
    [_filter setTopTitlesColor:[UIColor blackColor]];//设置滑块上方字体颜色
    [_filter setSelectedIndex:0];//设置当前选中
    [_filter setTitlesFont:[UIFont systemFontOfSize:15]];
    [_filter setDotRadius:10];
    [_filter setLineWidth:20];
    [self.view addSubview:_filter];
    
    
    _filter2 = [[SEFilterControl alloc]initWithFrame:CGRectMake(25, 450, self.view.frame.size.width-50, 15) Titles:[NSArray arrayWithObjects:@"50000", @"100000" , @"100000", nil]];
    [_filter2 addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    //    [_filter setAnimation:YES];
    [_filter2 setProgressColor:[UIColor groupTableViewBackgroundColor]];//设置滑杆的颜色
    [_filter2 setTopTitlesColor:[UIColor blackColor]];//设置滑块上方字体颜色
    [_filter2 setSelectedIndex:0];//设置当前选中
    [_filter2 setTitlesFont:[UIFont systemFontOfSize:15]];
    //    [_filter setDotRadius:20];
    //    [_filter setLineWidth:5];
    [self.view addSubview:_filter2];

}
#pragma mark -- 点击底部按钮响应事件
-(void)filterValueChanged:(SEFilterControl *)sender
{
    NSLog(@"当前滑块位置%d",sender.SelectedIndex);
    switch (sender.SelectedIndex) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
