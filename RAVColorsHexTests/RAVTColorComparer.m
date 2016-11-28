//
//  RAVTColorComparer.m
//  ColorsHex
//
//  Created by Andrew Romanov on 28/11/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import "RAVTColorComparer.h"
@import CoreImage;


@interface RAVTColorComparer (Private)

+ (void)_getComponentsFromColor:(UIColor*)color r:(CGFloat*)r g:(CGFloat*)g b:(CGFloat*)b a:(CGFloat*)a;
+ (BOOL)_componentsEqual:(CGFloat)component1 component2:(CGFloat)component2;

@end


@implementation RAVTColorComparer

+ (BOOL)colorsEqual:(UIColor*)color1 color2:(UIColor*)color2
{
	CGFloat r1, g1, b1, a1;
	[self _getComponentsFromColor:color1 r:&r1 g:&g1 b:&b1 a:&a1];
	
	CGFloat r2, g2, b2, a2;
	[self _getComponentsFromColor:color2 r:&r2 g:&g2 b:&b2 a:&a2];
	
	BOOL equal = ([self _componentsEqual:r1 component2:r2] &&
								[self _componentsEqual:g1 component2:g2] &&
								[self _componentsEqual:b1 component2:b2] &&
								[self _componentsEqual:a1 component2:a2]);
	return equal;
}

@end


#pragma mark -
@implementation RAVTColorComparer (Private)

+ (void)_getComponentsFromColor:(UIColor*)color r:(CGFloat*)red g:(CGFloat*)green b:(CGFloat*)blue a:(CGFloat*)alpha
{
	if (![color getRed:red green:green blue:blue alpha:alpha])
	{
		CIColor* coreColor = nil;
		if (color.CIColor)
		{
			coreColor = color.CIColor;
		}
		else
		{
			coreColor = [[CIColor alloc] initWithCGColor:color.CGColor];
		}
		
		*red = coreColor.red;
		*green = coreColor.green;
		*blue = coreColor.blue;
		*alpha = coreColor.alpha;
	}
}


+ (BOOL)_componentsEqual:(CGFloat)component1 component2:(CGFloat)component2
{
	const CGFloat epsilon = 1.0 / (256.0);
	BOOL equal = ABS(component1 - component2) <= epsilon;
	return equal;
}

@end
