//
//  EditManager.h
//  MapEditDemo
//
//  Created by imobile on 14-6-14.
//  Copyright (c) 2014年 imobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomSegmentedControl.h"
#import <SuperMap/SuperMap.h>
#import "SegImpSecond.h"
#import "Common.h"

@class MapControl;
@interface EditManager : NSObject<CustomSegmentedControlDelegate,GeometrySelectedDelegate,UIAlertViewDelegate,MapMeasureDelegate,TouchableViewDelegate>
{
    
}
@property(nonatomic,strong)MapControl* m_mapcontrol;
@property(nonatomic,strong)NSArray* segImpSecondArr;
-(id)init;
-(void)reset;
-(void)clear;
@end
