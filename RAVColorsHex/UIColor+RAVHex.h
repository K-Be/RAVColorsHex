//
//  UIColor+RAVHex.h
//  ColorsHex
//
//  Created by Andrew Romanov on 28/11/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef uint32_t rav_argb_t;
typedef uint8_t rav_colorComponent_t;


@interface UIColor (RAVHex)

- (rav_argb_t)rav_toHexARGB;
+ (UIColor*)rav_colorWithHexARGB:(rav_argb_t)argb;

+ (rav_argb_t)rav_hexARGBWithComponentsR:(rav_colorComponent_t)r G:(rav_colorComponent_t)g B:(rav_colorComponent_t)b A:(rav_colorComponent_t)a;

+ (NSString*)rav_stringWithHexARGB:(rav_argb_t)argb;
+ (rav_argb_t)rav_hexARGBWithString:(NSString*)string;

@end
