//
//  SegImp.m
//  MapEditDemo
//
//  Created by imobile on 14-6-12.
//  Copyright (c) 2014年 imobile. All rights reserved.
//

#import "SegImp.h"
#import <SuperMap/SuperMap.h>

@implementation SegImp
@synthesize btnArr,delegate,m_mapControl,em;

/**
 *一级菜单按钮关联监听
 */
-(void)process
{
    UIButton* btn;
    for(int i=0;i<[btnArr count];i++)
    {
        btn = btnArr[i];
        switch (i) {
            case 3:
                [btn addTarget:self action:@selector(btnUnDo:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 4:
                [btn addTarget:self action:@selector(btnRedo:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 5:
                [btn addTarget:self action:@selector(btnDel:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 6:
                [btn addTarget:self action:@selector(btnSubmit:) forControlEvents:UIControlEventTouchUpInside];
                break;
            default:
                [btn addTarget:self action:@selector(btnSecMenu:) forControlEvents:UIControlEventTouchUpInside];
                break;
        }
        
    }
}

#pragma mark 按键响应相关

/**
 *撤销
 */

-(void)btnUnDo:(id)sender{
       [m_mapControl undo];
}

/**
 *返回
 */

-(void)btnRedo:(id)sender{
    [m_mapControl redo];
}

/**
 *取消
*/
-(void)btnDel:(id)sender{
    [m_mapControl cancel];
    [em clear];
}

/**
 *是否可编辑
*/
-(BOOL)isEdit
{
    Layer* layer;
    BOOL ret = YES;
    if(m_mapControl.action==VERTEXEDIT||
       m_mapControl.action==VERTEXADD||
       m_mapControl.action==DELETENODE||
       m_mapControl.action==MEASUREAREA||
       m_mapControl.action==MEASURELENGTH)
        return ret;
    switch (m_mapControl.action) {
        case CREATEPOINT:
            //获取点图层
            layer = [m_mapControl.map.layers getLayerWithName:@"Point@edit"];
            if(layer == nil)
                ret = NO;
            break;
        case CREATEPOLYLINE:
            //获取点图层
            layer = [m_mapControl.map.layers getLayerWithName:@"Line@edit"];
            if(layer == nil)
                 ret = NO;
            break;
        case CREATEPOLYGON:
            //获取面图层
            layer = [m_mapControl.map.layers getLayerWithName:@"Region@edit"];
            if(layer == nil)
                 ret = NO;
            break;
        case CREATE_FREE_POLYLINE:
            //获取线图层
            layer = [m_mapControl.map.layers getLayerWithName:@"Line@edit"];
            if(layer == nil)
                 ret = NO;
            break;
        case CREATE_FREE_DRAWPOLYGON:
            //获取面图层
            layer = [m_mapControl.map.layers getLayerWithName:@"Region@edit"];
            if(layer == nil)
                 ret = NO;
            break;
        case CREATE_FREE_DRAW:
            //获取CAD图层
            layer = [m_mapControl.map.layers getLayerWithName:@"CAD@edit"];
            if(layer == nil)
                 ret = NO;
            break;
        default:
             ret = NO;
            break;
    }
    return ret;
}

/**
 *提交
*/
-(IBAction)btnSubmit:(id)sender
{
    //判断是否有相应的可编辑图层
    if([self isEdit])
        [m_mapControl submit];
    else
        [delegate notifyToView];
    [m_mapControl setAction:PAN];
    [em reset];
}

/**
 *触发二级菜单
*/
-(void)btnSecMenu:(id)sender
{
    UIButton* btn=sender;
    btn.selected = !btn.selected;
    for(UIButton* each in btnArr)
    {
        if(each.tag == btn.tag)
            continue;
        if( (each.tag>=0&&each.tag<=2) || each.tag==7)
            each.selected = NO;
    }
    if([delegate respondsToSelector:@selector(createSeg:)])
        [delegate createSeg:btn.tag];
}
@end
