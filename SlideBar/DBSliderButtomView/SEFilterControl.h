//
//  SEFilterControl.h
//  DBSlideButtonControl
//
//  Created by 邵朋磊 on 2017/8/24.
//  Copyright © 2017年 邵朋磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SEFilterControl : UIControl
/**
 *  滑动按钮
 */
@property(nonatomic, strong) UIButton *handler;
/**
 *  线条颜色
 */
@property(nonatomic, strong) UIColor *progressColor;
/**
 *  文字颜色
 */
@property(nonatomic, strong) UIColor *TopTitlesColor;
/**
 *  圆点半径
 */
@property(nonatomic,assign)int dotRadius;
/**
 *  线宽
 */
@property(nonatomic,assign)int lineWidth;
/**
 *  是否添加动画  注animation设置在setSelectedIndex方法前
 */
@property(nonatomic,assign)BOOL animation;
@property(nonatomic, readonly) int SelectedIndex;
-(id) initWithFrame:(CGRect) frame Titles:(NSArray *) titles;
/**
 *  初始化按钮位置
 */
-(void) setSelectedIndex:(int)index;
-(void) setTitlesFont:(UIFont *)font;
@end
