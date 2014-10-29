//
//  Common.m
//  MapEditDemo
//
//  Created by imobile on 14-6-11.
//  Copyright (c) 2014年 imobile. All rights reserved.
//

#import "Common.h"

@implementation Common

/**
 *图片缩放
 */

+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
@end
