//
//  EditManager.m
//  MapEditDemo
//
//  Created by imobile on 14-6-14.
//  Copyright (c) 2014年 imobile. All rights reserved.
//

#import "EditManager.h"
#import <SuperMap/SuperMap.h>
#import "SegImpSecond.h"
#import "Common.h"

@interface EditManager()
{
   //
}
@end

/**
 *地图编辑功能管理类
*/
@implementation EditManager
@synthesize m_mapcontrol,segImpSecondArr;


- (void) touchUpInsideSegmentIndex:(UIButton*)btn
{
    int segmentIndex = btn.tag;
    
    if(segmentIndex<10)
        [self addObj:btn];
    else if(segmentIndex>=10 && segmentIndex<20)
        [self editObj:btn];
    else if (segmentIndex>=20 && segmentIndex<30)
        [self setStyle:btn];
    else
        [self length:btn];
}
/**
 *量算入口
*/
-(void)length:(UIButton*)btn
{
    int index = btn.tag;
    
    if(index == 30)
        [m_mapcontrol setAction:MEASURELENGTH];/// 量算长度。
    else
        [m_mapcontrol setAction:MEASUREAREA];/// 量算面积。

    m_mapcontrol.mapMeasureDelegate = self;
}

/**
 *设置风格入口
*/
-(void)setStyle:(UIButton*)btn
{
    int segmentIndex = btn.tag;
    Color* color;
    switch (segmentIndex) {
        case 20:
            [m_mapcontrol setStrokeWidth:1.0];
            break;
        case 21:
            [m_mapcontrol setStrokeWidth:2.0];
            break;
        case 22:
            [m_mapcontrol setStrokeWidth:3.0];
            break;
        case 23:
            color = [[Color alloc]initWithR:255 G:240 B:0];
            [m_mapcontrol setStrokeColor:color];
            break;
        case 24:
            color = [[Color alloc]initWithR:255 G:0 B:0];
            [m_mapcontrol setStrokeColor:color];
            break;
        default:
            color = [[Color alloc]initWithR:0 G:186 B:255];
            [m_mapcontrol setStrokeColor:color];
            break;
    }
}

/**
 *编辑对象操作入口
*/
-(void)addObj:(UIButton*)btn
{
    int segmentIndex = btn.tag;

    switch (segmentIndex) {
        case 0:
            [self btnDrowPoint];
            break;
        case 1:
            [self btnDrowLine];
            break;
        case 2:
            [self btnDrowPolyGon];
            break;
        case 3:
            [self btnDrowFreeLine];
            break;
        case 4:
            [self btnDrowFreeArea];
            break;
        default:
            [self btnDrowTuya];
            break;
    }

}
#pragma mark 编辑相关

/**
 *对象编辑入口
*/
-(void)editObj:(UIButton*)btn
{
    m_mapcontrol.geometrySelectedDelegate = self;
   
    int segmentIndex = btn.tag;
    
    switch (segmentIndex) {
        case 10:
            [m_mapcontrol setAction:SELECT];///  在编辑模式下，长按选择对象，可对选中的对象进行编辑。
            break;
        case 11:
            [m_mapcontrol setAction:VERTEXEDIT];/// 在可编辑图层中编辑对象的节点。
            break;
        case 12:
            [m_mapcontrol setAction:VERTEXADD];/// 在可编辑图层中为对象添加节点。
            break;
        case 13:
            [m_mapcontrol setAction:DELETENODE];/// 在可编辑图层中删除对象的节点。
            break;
        default:
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否删除选中对象?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            [alert show];
            break;
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [m_mapcontrol deleteCurrentGeometry];/// 地图窗口上删除编辑对象操作。删除对象操作必须以地图编辑且地图上有选中的编辑对象为前提。
        
        [self p_reset];//清空状态
    }
}

/**
 *私有重置
*/
-(void)p_reset
{
    SegImpSecond* sis = segImpSecondArr[2];
    UIButton* each;
    for(int i=0;i<[sis->buttons2 count];i++)
    {
        each = sis->buttons2[i];
        each.selected = NO;
        if(i!=0)
        {
            [each setUserInteractionEnabled:NO];
        }
    }
    sis = segImpSecondArr[0];
    each = sis->buttons4[0];
    each.selected = NO;
    each = sis->buttons4[1];
    each.selected = NO;
}

/**
 *重置
*/
-(void)reset
{
    [self p_reset];
    
    SegImpSecond*  sis = segImpSecondArr[1];
    for(UIButton* each in sis->buttons1)
    {
        each.selected = NO;
    }

}

/**
 *清空所有状态
*/
-(void)clear
{
    [self p_reset];
    [self reset];
    SegImpSecond* sis = segImpSecondArr[0];
    sis = segImpSecondArr[0];
    sis->m_lable.text = @"";
}

/**
 *将面积单位转换为字符串显示
*/
/*-(NSString*)unitTostring:(Unit)unit
{
    NSString *strUnit;
    switch (unit) {
        case METER:
            strUnit = @"米";
            break;
        case SQUAREMETER:
            strUnit = @"平方米";
            break;
        case KILOMETER:
            strUnit = @"公里";
            break;
        case SQUAREKILOMETER:
            strUnit = @"平方公里";
            break;
        default:
            break;
    }
    return strUnit;
}
*/
#pragma mark 协议相关

/**
 *手势抬起自动提交点
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    if(m_mapcontrol.action == CREATEPOINT){
        Layer* layer = [m_mapcontrol.map.layers getLayerWithName:@"Point@edit"];
        if(layer == nil)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"缺少可编辑点图层" message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
             UIImageView* img = [[UIImageView alloc]initWithImage:[Common scaleToSize:[UIImage imageNamed:@"bg_submit.png"] size:CGSizeMake(230, 130)]];
            
            [alert show];
            return;
        }
        [m_mapcontrol submit];
    }
}

/**
 *选中对象执行回调
*/
-(void)geometrySelected:(int)geometryID LayerIndex:(int)layerIndex
{

    Layer* layer = [m_mapcontrol.map.layers getLayerAtIndex:layerIndex];
    [m_mapcontrol appointEditGeometryWithID:geometryID Layer:layer];//指定编辑对象所在图层可编辑

    SegImpSecond* sis = segImpSecondArr[2];
    UIButton* each;
    for(int i=0;i<[sis->buttons2 count];i++)
    {
        each = sis->buttons2[i];
        [each setUserInteractionEnabled:YES];
        if(i==0)
            each.selected = NO;
        if(i==1)
            each.selected = YES;
    }
}

/**
 *获取地图量算结果回调
 */
/**
 * @brief 获取地图量算结果。
 * @param  result 地图量算结果。
 * @param unit  距离单位。
 * @param lastPoint 量算时绘制的最后一个点 。
 */
-(double)getMeasureResult:(double)result  lastPoint:(Point2D*)lastPoint
{
    SegImpSecond* sis = segImpSecondArr[0];
    
    NSString *strResult = [NSString stringWithFormat:@"结果: %.3f 米",result];
    sis->m_lable.text = strResult;
    return 0.0;
}
#pragma mark 添加相关

/**
 *添加点
 */
-(void)btnDrowPoint
{
    [m_mapcontrol setAction:CREATEPOINT]; /// 在可编辑图层中画点。
    Layer* layer = [m_mapcontrol.map.layers getLayerWithName:@"Point@edit"];
    if(layer == nil)
        return;
    [layer setEditable:YES];
}

/**
 *添加线
*/
-(void)btnDrowLine
{
    [m_mapcontrol setAction:CREATEPOLYLINE];/// 在可编辑图层中画折线。
    Layer* layer = [m_mapcontrol.map.layers getLayerWithName:@"Line@edit"];
    if(layer == nil)
        return;
    [layer setEditable:YES];
}

/**
 *添加面
*/
-(void)btnDrowPolyGon
{
    [m_mapcontrol setAction:CREATEPOLYGON];/// 在可编辑图层中画多边形。
    Layer* layer = [m_mapcontrol.map.layers getLayerWithName:@"Region@edit"];
    if(layer == nil)
        return;
    [layer setEditable:YES];
}

/**
 *自由线
*/
-(void)btnDrowFreeLine
{
    [m_mapcontrol setAction: CREATE_FREE_POLYLINE];///  自由线。
    Layer* layer = [m_mapcontrol.map.layers getLayerWithName:@"Line@edit"];
    if(layer == nil)
        return;
    [layer setEditable:YES];
    
}

/**
 *自由面
*/
-(void)btnDrowFreeArea
{
    [m_mapcontrol setAction: CREATE_FREE_DRAWPOLYGON]; ///  自由绘制。
    Layer* layer = [m_mapcontrol.map.layers getLayerWithName:@"Region@edit"];
    if(layer == nil)
        return;
    [layer setEditable:YES];
}

/**
 *涂鸦
*/
-(void)btnDrowTuya
{
    [m_mapcontrol setAction: CREATE_FREE_DRAW];  ///  自由绘制。
    Layer* layer = [m_mapcontrol.map.layers getLayerWithName:@"CAD@edit"];
    if(layer == nil)
        return;
    [layer setEditable:YES];
}


@end
