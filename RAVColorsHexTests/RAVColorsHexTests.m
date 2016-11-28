//
//  RAVColorsHexTests.m
//  RAVColorsHexTests
//
//  Created by Andrew Romanov on 28/11/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RAVColorsHex.h"
#import "RAVTColorComparer.h"

@interface RAVColorsHexTests : XCTestCase

@end


@implementation RAVColorsHexTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBackForvardConverting
{
	UIColor* sourceColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
	rav_argb_t code = [sourceColor rav_toHexARGB];
	UIColor* restoredColor = [UIColor rav_colorWithHexARGB:code];
	XCTAssert([RAVTColorComparer colorsEqual:sourceColor color2:restoredColor]);
}

- (void)testWhiteColor
{
	UIColor* sourceColor = [UIColor whiteColor];
	rav_argb_t code = [sourceColor rav_toHexARGB];
	UIColor* restoredColor = [UIColor rav_colorWithHexARGB:code];
	XCTAssert([RAVTColorComparer colorsEqual:sourceColor color2:restoredColor]);
}


- (void)testWithHexString
{
	NSString* color =@"ffffff";
	rav_argb_t colorCode = [UIColor rav_hexARGBWithString:color];
	UIColor* resultColor = [UIColor rav_colorWithHexARGB:colorCode];
	XCTAssert([RAVTColorComparer colorsEqual:[UIColor whiteColor] color2:resultColor]);
}


- (void)testWithHexAlphaString
{
	NSString* color =@"00ffffff";
	UIColor* resultColor = [UIColor rav_colorWithHexARGB:[UIColor rav_hexARGBWithString:color]];
	XCTAssert([RAVTColorComparer colorsEqual:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0] color2:resultColor]);
}


- (void)testPerformanceBackForward
{
    // This is an example of a performance test case.
    [self measureBlock:^{
			UIColor* sourceColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
			rav_argb_t code = [sourceColor rav_toHexARGB];
			[UIColor rav_colorWithHexARGB:code];
    }];
}

@end
