//
//  SegImpSecond.m
//  MapEditDemo
//
//  Created by imobile on 14-6-14.
//  Copyright (c) 2014年 imobile. All rights reserved.
//
#import <SuperMap/SuperMap.h>
#import "SegImpSecond.h"

@interface SegImpSecond()
{

   // NSMutableArray* buttons1,* buttons2,* buttons3;
  //  UILabel* _lable;
}
@end
@implementation SegImpSecond
@synthesize isClick,tag,mainView,delegate;

-(id)init
{
    if(self=[super init])
    {
        buttons1 = [NSMutableArray array];
        buttons2 = [NSMutableArray array];
        buttons3 = [NSMutableArray array];
        buttons4 = [NSMutableArray array];
        
        m_lable = [[UILabel alloc]initWithFrame:CGRectMake(300+105, 15, 220, 45)];
        m_lable.textAlignment = NSTextAlignmentCenter;
        m_lable.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


/**
 *二级菜单点击触发入口
 */
- (void) dimAllButtonsExcept:(UIButton *)selectedButton: (NSArray*)buttons
{
    static BOOL preSection = NO;
    
    
    //控制风格设置按钮状态
    if(buttons == buttons3)
    {
        if(selectedButton.tag>=20 && selectedButton.tag<=22)
            preSection = YES;
        else
            preSection = NO;
    }
    for (UIButton *button in buttons)
  
        if (button == selectedButton)
            button.selected = YES;
        else
            if(buttons == buttons3){
                if(preSection){
                    if( button.tag>=20 && button.tag<=22)
                        button.selected = NO;
                }else
                    if( button.tag>=23 && button.tag<=25)
                        button.selected = NO;
            }else
                button.selected = NO;
  
}


- (void)touchUpInsideAction:(UIButton *)button
{
    NSArray* buttons;
    if(0<=button.tag &&button.tag<10)
        buttons = buttons1;
    else if(10<=button.tag && button.tag<20)
        buttons = buttons2;
    else if(20<=button.tag && button.tag<30)
        buttons = buttons3;
    else
        buttons = buttons4;
    
    [self dimAllButtonsExcept:button:buttons];
    if([delegate respondsToSelector:@selector(touchUpInsideSegmentIndex:)])
    {
        [delegate touchUpInsideSegmentIndex:button];
    }
}


/**
 *创建二级菜单
 */
-(UIView*)process
{
        switch (tag) {
        case 0:
            [self zeroView];
            break;
        case 1:
            [self firstView];
            break;
        case 2:
             [self secondView];
            break;
        case 3:
             [self thridView];
            break;
    }
    return mainView;
}


/**
 *量算菜单创建
 */
-(void)zeroView
{
    
    NSArray* imgArr = @[@"03-编辑对象未选_距离量算.png",@"03-编辑对象未选_面积量算.png"];
    
    NSArray* imgArrSel = @[@"03-编辑对象选中_距离量算.png",@"03-编辑对象选中_面积量算.png"];
    mainView = [[UIView alloc]initWithFrame:CGRectMake(30.0, 92, 640, 70.0)];
    mainView.backgroundColor = [UIColor blackColor];
    mainView.hidden = YES;
    
    for (int i=0; i<3; i++)
    {
        if(i == 0)
        {
            // 编辑_二级菜单辅助箭头.png
            //CGRectMake(27+80*7, 0, 25, 30)];
            UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(27+80+80, 0, 25, 30)];
            img.image = [UIImage imageNamed:@"编辑_二级菜单辅助箭头.png"];
            UILabel* lable = [[UILabel alloc]initWithFrame:CGRectMake(7+80+80, 10, 80, 55)];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.text = @"量算";
            [lable setTextColor:[UIColor colorWithRed:77.0f/255.0f green:197.0f/255.0f blue:195.0f/255.0f alpha:1.0f]];
            [mainView addSubview:img];
            [mainView addSubview:lable];
            continue;
        }
        UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(15+80*i+80+80, 10, 55, 60)];
        button.tag = i-1+30;
        [button setBackgroundImage:[UIImage imageNamed:[imgArr objectAtIndex:i-1]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[imgArrSel objectAtIndex:i-1]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        [buttons4 addObject:button];
        [mainView addSubview:button];
    }
    [mainView addSubview:m_lable];
}


/**
 *编辑菜单创建
 */
-(void)secondView
{

    NSArray* imgArr = @[@"编辑对象未选_选中对象.png",@"编辑对象未选_编辑节点.png",@"编辑对象未选_添加节点.png",@"编辑对象未选_删除节点.png",@"编辑对象未选_删除对象.png"];
    
    NSArray* imgArrSel = @[@"编辑对象选中_选中对象.png",@"编辑对象选中_编辑节点.png",@"编辑对象选中_添加节点.png",@"编辑对象选中_删除节点.png",@"编辑对象选中_删除对象.png"];
    mainView = [[UIView alloc]initWithFrame:CGRectMake(30.0, 92, 640, 70.0)];
    mainView.backgroundColor = [UIColor blackColor];
    mainView.hidden = YES;
    for (int i=2; i<8; i++)
    {
        if(i == 2)
        {
            // 编辑_二级菜单辅助箭头.png
            UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(27+80, 0, 25, 30)];
            img.image = [UIImage imageNamed:@"编辑_二级菜单辅助箭头.png"];
            UILabel* lable = [[UILabel alloc]initWithFrame:CGRectMake(7+80, 10, 80, 55)];
            lable.text = @"编辑对象";
            [lable setTextColor:[UIColor colorWithRed:77.0f/255.0f green:197.0f/255.0f blue:195.0f/255.0f alpha:1.0f]];
            [mainView addSubview:img];
            [mainView addSubview:lable];
            continue;
        }
        UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(15+80*i, 10, 55, 60)];
        button.tag = i-3+10;
        [button setBackgroundImage:[UIImage imageNamed:[imgArr objectAtIndex:i-3]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[imgArrSel objectAtIndex:i-3]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        if(i!=3)
            [button setUserInteractionEnabled:NO];
        [buttons2 addObject:button];
        [mainView addSubview:button];
        
    }
    
}


/**
 *风格菜单创建
 */
-(UIView*)thridView
{
    NSArray* imgArr = @[@"03-编辑设置未选_细线.png",@"03-编辑设置未选_中细线.png",@"03-编辑设置未选_粗线.png",@"03-编辑设置未选_黄.png",@"03-编辑设置未选_红.png",@"03-编辑设置未选_蓝.png"];
    NSArray* imgArrSel = @[@"03-编辑设置选中_细线.png",@"03-编辑设置选中_中细线.png",@"03-编辑设置选中_粗线.png",@"03-编辑设置选中_黄.png",@"03-编辑设置选中_红.png",@"03-编辑设置选中_蓝.png"];
    mainView = [[UIView alloc]initWithFrame:CGRectMake(30.0, 92, 640, 70.0)];
    mainView.backgroundColor = [UIColor blackColor];
    mainView.hidden = YES;           
    for (int i=0; i<8; i++)
    {
        if(i==6)
            continue;
        if(i == 7)
        {
            // 编辑_二级菜单辅助箭头.png
            UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(27+80*7, 0, 25, 30)];
            img.image = [UIImage imageNamed:@"编辑_二级菜单辅助箭头.png"];
            UILabel* lable = [[UILabel alloc]initWithFrame:CGRectMake(7+80*7, 10, 80, 55)];
            lable.text = @"风格设置";
            [lable setTextColor:[UIColor colorWithRed:77.0f/255.0f green:197.0f/255.0f blue:195.0f/255.0f alpha:1.0f]];
            [mainView addSubview:img];
            [mainView addSubview:lable];
            continue;
        }
        UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(15+80*i, 5, 55, 60)];
        [button addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];

        button.tag = i+20;
        [button setBackgroundImage:[UIImage imageNamed:[imgArr objectAtIndex:i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[imgArrSel objectAtIndex:i]] forState:UIControlStateSelected];
        [mainView addSubview:button];
        [buttons3 addObject:button];
    }
    
    return mainView;
}


/**
 *对象添加菜单创建
*/
-(UIView*)firstView
{
    NSArray* imgArr = @[@"添加未选_点.png",@"添加未选_线.png",@"添加未选_面.png",@"添加未选_自由线.png",@"添加未选_自由面.png",@"添加未选_涂鸦.png"];
    NSArray* imgArrSel = @[@"添加选中_点.png",@"添加选中_线.png",@"添加选中_面.png",@"添加选中_自由线.png",@"添加选中_自由面.png",@"添加选中_涂鸦.png.png"];
    mainView = [[UIView alloc]initWithFrame:CGRectMake(30.0, 92, 640.0, 70.0)];
    mainView.backgroundColor = [UIColor blackColor];
    mainView.hidden = YES;
    for (int i=1; i<8; i++)
    {
        if(i == 1)
        {
            // 编辑_二级菜单辅助箭头.png
            UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(27, 0, 25, 30)];
            img.image = [UIImage imageNamed:@"编辑_二级菜单辅助箭头.png"];
            UILabel* lable = [[UILabel alloc]initWithFrame:CGRectMake(7, 10, 80, 55)];
            lable.text = @"添加对象";
            [lable setTextColor:[UIColor colorWithRed:77.0f/255.0f green:197.0f/255.0f blue:195.0f/255.0f alpha:1.0f]];
            [mainView addSubview:img];
            [mainView addSubview:lable];
            continue;
        }
        UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(15+80*i, 10, 55, 60)];
        [button addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];

        button.tag = i-2;
        [button setBackgroundImage:[UIImage imageNamed:[imgArr objectAtIndex:i-2]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[imgArrSel objectAtIndex:i-2]] forState:UIControlStateSelected];
        [mainView addSubview:button];
        [buttons1 addObject:button];
    }
    
    return mainView;
}
@end
