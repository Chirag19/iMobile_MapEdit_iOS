//
//  CustomSegmentedControl.h
//  MapEditDemo
//
//  Created by imobile on 14-6-17.
//  Copyright (c) 2014年 imobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSegmentedControl;
@protocol CustomSegmentedControlDelegate<NSObject>

- (UIButton *) buttonFor:(CustomSegmentedControl *)segmentedControl atIndex:(NSUInteger)segmentIndex;

@optional
- (void) touchUpInsideSegmentIndex:(UIButton *)btn;
@end


