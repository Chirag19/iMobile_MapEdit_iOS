//
//  SegImp.h
//  MapEditDemo
//
//  Created by imobile on 14-6-12.
//  Copyright (c) 2014年 imobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditManager.h"

@protocol CreateSegDelegate <NSObject>

-(void)createSeg:(int)index;
-(void)notifyToView;
@end
@class MapControl;
@interface SegImp : NSObject
{
    
}

@property(nonatomic,strong)NSArray* btnArr;
@property(nonatomic,assign)id<CreateSegDelegate>delegate;
@property(nonatomic,strong)MapControl* m_mapControl;
@property(nonatomic,strong)EditManager* em;
-(void)process;
@end
