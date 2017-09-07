//
//  SEFilterControl.m
//  DBSlideButtonControl
//
//  Created by 邵朋磊 on 2017/8/24.
//  Copyright © 2017年 邵朋磊. All rights reserved.
//

#import "SEFilterControl.h"

#define LEFT_OFFSET 20
#define RIGHT_OFFSET 20
#define TITLE_SELECTED_DISTANCE 9
#define TITLE_FADE_ALPHA 0.5f
#define TITLE_FONT [UIFont systemFontOfSize:10]
#define TITLE_SHADOW_COLOR [UIColor lightGrayColor]
#define TITLE_COLOR [UIColor blackColor]

@interface SEFilterControl (){
    CGPoint diffPoint;
    NSArray *titlesArr;
    float oneSlotSize;
}

@end

@implementation SEFilterControl
@synthesize SelectedIndex, progressColor,TopTitlesColor;

-(CGPoint)getCenterPointForIndex:(int) i{
    return CGPointMake((i/(float)(titlesArr.count-1)) * (self.frame.size.width-RIGHT_OFFSET-LEFT_OFFSET) + LEFT_OFFSET, i==0?self.frame.size.height-55-TITLE_SELECTED_DISTANCE:self.frame.size.height-55);
}

-(CGPoint)fixFinalPoint:(CGPoint)pnt{
    if (pnt.x < LEFT_OFFSET-(_handler.frame.size.width/2.f)) {
        pnt.x = LEFT_OFFSET-(_handler.frame.size.width/2.f);
    }else if (pnt.x+(_handler.frame.size.width/2.f) > self.frame.size.width-RIGHT_OFFSET){
        pnt.x = self.frame.size.width-RIGHT_OFFSET- (_handler.frame.size.width/2.f);
        
    }
    return pnt;
}

-(id) initWithFrame:(CGRect) frame Titles:(NSArray *) titles{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y-30, frame.size.width, 50)]) {
        [self setBackgroundColor:[UIColor clearColor]];
        titlesArr = [[NSArray alloc] initWithArray:titles];
        
        [self setProgressColor:[UIColor colorWithRed:103/255.f green:173/255.f blue:202/255.f alpha:1]];
        [self setTopTitlesColor:[UIColor colorWithRed:103/255.f green:173/255.f blue:202/255.f alpha:1]];
        self.dotRadius = 10;
        self.lineWidth = 10;
        self.animation = NO;
        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ItemSelected:)];
        [self addGestureRecognizer:gest];
        
        _handler = [UIButton buttonWithType:UIButtonTypeCustom];
        [_handler setFrame:CGRectMake(LEFT_OFFSET, 8, 45, 45)];
        [_handler setAdjustsImageWhenHighlighted:NO];
        [_handler setSelected:YES];
        [_handler setCenter:CGPointMake(_handler.center.x-(_handler.frame.size.width/2.f), self.frame.size.height-32.5f)];
        [_handler addTarget:self action:@selector(TouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
        [_handler addTarget:self action:@selector(TouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
        [_handler addTarget:self action:@selector(TouchMove:withEvent:) forControlEvents: UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
        
        UIImage *image1 = [UIImage imageNamed:@"timg-2.jpeg"];
        UIImage *image2 = [UIImage imageNamed:@"timg-2.jpeg"];
        
        CGFloat top = 0; // 顶端盖高度
        
        CGFloat bottom = 0 ; // 底端盖高度
        
        CGFloat left = 0; // 左端盖宽度
        
        CGFloat right = 0; // 右端盖宽度
        
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        
        image1 = [image1 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        image2 = [image2 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        [_handler setBackgroundImage:image1 forState:UIControlStateNormal];
        [_handler setBackgroundImage:image2 forState:UIControlStateSelected];
        
        [self addSubview:_handler];
        
        int i;
        NSString *title;
        UILabel *lbl;
        
        oneSlotSize = 1.f*(self.frame.size.width-LEFT_OFFSET-RIGHT_OFFSET-1)/(titlesArr.count-1);
        for (i = 0; i < titlesArr.count; i++) {
            title = [titlesArr objectAtIndex:i];
            lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, oneSlotSize, 25)];
            [lbl setText:title];
            [lbl setFont:TITLE_FONT];
            [lbl setTextColor:TITLE_COLOR];
            [lbl setLineBreakMode:NSLineBreakByTruncatingMiddle];
            [lbl setAdjustsFontSizeToFitWidth:YES];
            [lbl setTextAlignment:NSTextAlignmentCenter];
            [lbl setShadowOffset:CGSizeMake(0, 1)];
            [lbl setTag:i+50];
            
            if (i) {
                [lbl setAlpha:TITLE_FADE_ALPHA];
            }
            
            [lbl setCenter:[self getCenterPointForIndex:i]];
            [self addSubview:lbl];
        }
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    if (self.dotRadius<self.lineWidth) {
        self.dotRadius = self.lineWidth;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Fill Main Path
    CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
    CGContextFillRect(context, CGRectMake(LEFT_OFFSET, rect.size.height-32.5-self.lineWidth/2, rect.size.width-RIGHT_OFFSET-LEFT_OFFSET, self.lineWidth));
    CGContextSaveGState(context);
    
    CGPoint centerPoint;
    int i;
    for (i = 0; i < titlesArr.count; i++) {
        centerPoint = [self getCenterPointForIndex:i];
        //Draw Selection Circles 小圆圈
        CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
        CGContextFillEllipseInRect(context, CGRectMake(centerPoint.x-self.dotRadius/2, rect.size.height-32.5f-self.dotRadius/2, self.dotRadius, self.dotRadius));
    }
}


- (void) TouchDown: (UIButton *) btn withEvent: (UIEvent *) ev{
    CGPoint currPoint = [[[ev allTouches] anyObject] locationInView:self];
    diffPoint = CGPointMake(currPoint.x - btn.frame.origin.x, currPoint.y - btn.frame.origin.y);
    [self sendActionsForControlEvents:UIControlEventTouchDown];
}


-(void) setTitlesFont:(UIFont *)font{
    int i;
    UILabel *lbl;
    for (i = 0; i < titlesArr.count; i++) {
        lbl = (UILabel *)[self viewWithTag:i+50];
        [lbl setFont:font];
    }
}

-(void) animateTitlesToIndex:(int) index{
    int i;
    UILabel *lbl;
    for (i = 0; i < titlesArr.count; i++) {
        lbl = (UILabel *)[self viewWithTag:i+50];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        if (i == index) {
            //选中时label颜色
            [lbl setCenter:CGPointMake(lbl.center.x, self.frame.size.height+TITLE_SELECTED_DISTANCE)];
            [lbl setTextColor: self.TopTitlesColor];
            [lbl setAlpha:1];
        }else{
            //未选中时label颜色
            [lbl setCenter:CGPointMake(lbl.center.x, self.frame.size.height+(self.animation==YES?0:TITLE_SELECTED_DISTANCE))];
            [lbl setTextColor:TITLE_COLOR];
            [lbl setAlpha:1];
        }
        [UIView commitAnimations];
    }
}

-(void) animateHandlerToIndex:(int) index{
    CGPoint toPoint = [self getCenterPointForIndex:index];
    toPoint = CGPointMake(toPoint.x-(_handler.frame.size.width/2.f), _handler.frame.origin.y);
    toPoint = [self fixFinalPoint:toPoint];
    
    [UIView beginAnimations:nil context:nil];
    [_handler setFrame:CGRectMake(toPoint.x, toPoint.y, _handler.frame.size.width, _handler.frame.size.height)];
    [UIView commitAnimations];
}

-(void) setSelectedIndex:(int)index{
    SelectedIndex = index;
    [self animateTitlesToIndex:index];
    [self animateHandlerToIndex:index];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(int)getSelectedTitleInPoint:(CGPoint)pnt{
    return round((pnt.x-LEFT_OFFSET)/oneSlotSize);
}

-(void) ItemSelected: (UITapGestureRecognizer *) tap {
    SelectedIndex = [self getSelectedTitleInPoint:[tap locationInView:self]];
    [self setSelectedIndex:SelectedIndex];
    
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void) TouchUp: (UIButton*) btn{
    btn.selected = YES;
    SelectedIndex = [self getSelectedTitleInPoint:btn.center];
    [self animateHandlerToIndex:SelectedIndex];
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void) TouchMove: (UIButton *) btn withEvent: (UIEvent *) ev {
    btn.selected = NO;
    CGPoint currPoint = [[[ev allTouches] anyObject] locationInView:self];
    
    CGPoint toPoint = CGPointMake(currPoint.x-diffPoint.x, _handler.frame.origin.y);
    
    toPoint = [self fixFinalPoint:toPoint];
    
    [_handler setFrame:CGRectMake(toPoint.x, toPoint.y, _handler.frame.size.width, _handler.frame.size.height)];
    
    int selected = [self getSelectedTitleInPoint:btn.center];
    
    [self animateTitlesToIndex:selected];
    
    [self sendActionsForControlEvents:UIControlEventTouchDragInside];
}
@end
