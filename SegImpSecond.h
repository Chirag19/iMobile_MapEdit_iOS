//
//  SegImpSecond.h
//  MapEditDemo
//
//  Created by imobile on 14-6-14.
//  Copyright (c) 2014年 imobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomSegmentedControl.h"
@interface SegImpSecond : NSObject
{   @public
        NSMutableArray* buttons1,* buttons2,* buttons3,* buttons4;
        UILabel* m_lable;
}
@property(nonatomic,assign)BOOL isClick;
@property(nonatomic,assign)int tag;
@property(nonatomic,strong)UIView* mainView;
@property(nonatomic,assign)id<CustomSegmentedControlDelegate> delegate;
-(UIView*)process;

-(id)init;
@end
