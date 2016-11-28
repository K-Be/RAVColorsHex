//
//  UIColor+RAVHex.m
//  ColorsHex
//
//  Created by Andrew Romanov on 28/11/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import "UIColor+RAVHex.h"
#import "NSString+RAVHexString.h"
@import CoreImage;

//indexes from right
#define COMPONENT_INDEX_ALPHA (3)
#define COMPONENT_INDEX_RED (2)
#define COMPONENT_INDEX_GREEN (1)
#define COMPONENT_INDEX_BLUE (0)


CG_INLINE rav_colorComponent_t ravP_colorComponenWithFloatValue(CGFloat componentValue)
{
	rav_colorComponent_t value = (rav_colorComponent_t)(componentValue * 255.0 + 0.5);
	return value;
}


CG_INLINE int8_t ravP_shiftForColorComponentWithIndex(int8_t colorComponentIndex)
{
	int8_t cellIndexFromRight = colorComponentIndex;
	int8_t step = sizeof(rav_colorComponent_t) * BYTE_SIZE;
	
	return cellIndexFromRight * step;
}


CG_INLINE rav_colorComponent_t ravP_readComponentAtNumber(rav_argb_t color, int8_t componentNumber)
{
	int8_t shift = ravP_shiftForColorComponentWithIndex(componentNumber);
	rav_colorComponent_t component = (color >> shift);
	return component;
}


CG_INLINE CGFloat ravP_colorComponentToFloatValue(rav_colorComponent_t colorComponent)
{
	CGFloat value = (((CGFloat)colorComponent) / 255.0);
	return value;
}


@implementation UIColor (RAVHex)

- (rav_argb_t)rav_toHexARGB
{
	CGFloat red;
	CGFloat green;
	CGFloat blue;
	CGFloat alpha;
	
	if (![self getRed:&red green:&green blue:&blue alpha:&alpha])
	{
		CIColor* coreColor = nil;
		if (self.CIColor)
		{
			coreColor = self.CIColor;
		}
		else
		{
			coreColor = [[CIColor alloc] initWithCGColor:self.CGColor];
		}
		
		red = coreColor.red;
		green = coreColor.green;
		blue = coreColor.blue;
		alpha = coreColor.alpha;
	}
	
	rav_colorComponent_t r = ravP_colorComponenWithFloatValue(red);
	rav_colorComponent_t g = ravP_colorComponenWithFloatValue(green);
	rav_colorComponent_t b = ravP_colorComponenWithFloatValue(blue);
	rav_colorComponent_t a = ravP_colorComponenWithFloatValue(alpha);
	
	rav_argb_t color = [UIColor rav_hexARGBWithComponentsR:r G:g B:b A:a];
	
	return color;
}


+ (UIColor*)rav_colorWithHexARGB:(rav_argb_t)argb
{
	rav_colorComponent_t a = ravP_readComponentAtNumber(argb, COMPONENT_INDEX_ALPHA);
	rav_colorComponent_t r = ravP_readComponentAtNumber(argb, COMPONENT_INDEX_RED);
	rav_colorComponent_t g = ravP_readComponentAtNumber(argb, COMPONENT_INDEX_GREEN);
	rav_colorComponent_t b = ravP_readComponentAtNumber(argb, COMPONENT_INDEX_BLUE);
	
	UIColor* color = [UIColor colorWithRed:ravP_colorComponentToFloatValue(r)
																	 green:ravP_colorComponentToFloatValue(g)
																		blue:ravP_colorComponentToFloatValue(b)
																	 alpha:ravP_colorComponentToFloatValue(a)];
	return color;
}


+ (rav_argb_t)rav_hexARGBWithComponentsR:(rav_colorComponent_t)r G:(rav_colorComponent_t)g B:(rav_colorComponent_t)b A:(rav_colorComponent_t)a
{
	rav_argb_t bigA = a;
	rav_argb_t bigR = r;
	rav_argb_t bigG = g;
	rav_argb_t bigB = b;
	
	rav_argb_t color = ((bigA << ravP_shiftForColorComponentWithIndex(COMPONENT_INDEX_ALPHA)) |
											(bigR << ravP_shiftForColorComponentWithIndex(COMPONENT_INDEX_RED)) |
											(bigG << ravP_shiftForColorComponentWithIndex(COMPONENT_INDEX_GREEN)) |
											(bigB << ravP_shiftForColorComponentWithIndex(COMPONENT_INDEX_BLUE)));
	return color;
}


+ (NSString*)rav_stringWithHexARGB:(rav_argb_t)argb
{
	rav_colorComponent_t a = ravP_readComponentAtNumber(argb, COMPONENT_INDEX_ALPHA);
	rav_colorComponent_t r = ravP_readComponentAtNumber(argb, COMPONENT_INDEX_RED);
	rav_colorComponent_t g = ravP_readComponentAtNumber(argb, COMPONENT_INDEX_GREEN);
	rav_colorComponent_t b = ravP_readComponentAtNumber(argb, COMPONENT_INDEX_BLUE);
	
	NSString* stringWithFormat = [NSString stringWithFormat:@"%2X%2X%2X%2X", a, r, g, b];

	return stringWithFormat;
}


+ (rav_argb_t)rav_hexARGBWithString:(NSString*)string
{
	NSString* clearString = [string rav_removeNotHexNumbersChracters];
	
	NSScanner* scanner = [[NSScanner alloc] initWithString:clearString];
	
	rav_argb_t baseValue;
	[scanner scanHexInt:&baseValue];
	
	//2 characters for one channel
	rav_colorComponent_t alpha = 255;
	if (string.length < 8 && baseValue <= 0xFFFFFF)
	{
		alpha = 255;
	}
	else
	{
		alpha = ravP_readComponentAtNumber(baseValue, COMPONENT_INDEX_ALPHA);
	}
	
	rav_colorComponent_t red = ravP_readComponentAtNumber(baseValue, COMPONENT_INDEX_RED);
	rav_colorComponent_t green = ravP_readComponentAtNumber(baseValue, COMPONENT_INDEX_GREEN);
	rav_colorComponent_t blue = ravP_readComponentAtNumber(baseValue, COMPONENT_INDEX_BLUE);
	
	rav_argb_t colorCode = [UIColor rav_hexARGBWithComponentsR:red G:green B:blue A:alpha];
	
	return colorCode;
}

@end
