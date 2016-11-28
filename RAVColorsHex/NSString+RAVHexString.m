//
//  NSString+RAVHexString.m
//  ColorsHex
//
//  Created by Andrew Romanov on 28/11/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import "NSString+RAVHexString.h"

@implementation NSString (RAVHexString)

- (NSString*)rav_removeNotHexNumbersChracters
{
	static NSCharacterSet* set = nil;
	static NSCharacterSet* inversetSet = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDFabcdf"];
		inversetSet = [set invertedSet];
	});
	
	NSString* result = nil;
	if ([self rangeOfCharacterFromSet:inversetSet].location == NSNotFound)
	{
		result = self;
	}
	else
	{
		NSScanner* scanner = [[NSScanner alloc] initWithString:self];
		NSMutableString* clearString = [[NSMutableString alloc] init];
		
		while (![scanner isAtEnd])
		{
			NSString* buffer = nil;
			if([scanner scanCharactersFromSet:set intoString:&buffer])
			{
				[clearString appendString:buffer];
			}
			else
			{
				[scanner setScanLocation:[scanner scanLocation] + 1];
			}
		}
		
		result = clearString;
	}
	
	return result;
}


@end
