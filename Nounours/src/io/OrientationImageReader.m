//
//  OrientationImageReader.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/28/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import "OrientationImageReader.h"
#import "../data/OrientationImage.h"


@implementation OrientationImageReader
NSString * const COL_OI_IMAGE_ID = @"ImageId";
NSString * const COL_OI_MIN_YAW = @"MinYaw";
NSString * const COL_OI_MAX_YAW = @"MaxYaw";
NSString * const COL_OI_MIN_PITCH = @"MinPitch";
NSString * const COL_OI_MAX_PITCH = @"MaxPitch";
NSString * const COL_OI_MIN_ROLL = @"MinRoll";
NSString * const COL_OI_MAX_ROLL = @"MaxRoll";

@synthesize orientationImages;
-(OrientationImageReader*) initOrientationImageReader:(NSString*) pfilename{
	self = [super initNounoursReader:pfilename];
	orientationImages = [[NSMutableSet alloc] init];
	[self load];
	return self;
}
-(void) readLine:(CSVReader *)pcsvReader{
	NSString *imageId = [pcsvReader getValue:COL_OI_IMAGE_ID];
	CGFloat minYaw = [[pcsvReader getValue:COL_OI_MIN_YAW] floatValue];
	CGFloat maxYaw = [[pcsvReader getValue:COL_OI_MAX_YAW] floatValue];
	CGFloat minPitch = [[pcsvReader getValue:COL_OI_MIN_PITCH] floatValue];
	CGFloat maxPitch = [[pcsvReader getValue:COL_OI_MAX_PITCH] floatValue];	
	CGFloat minRoll = [[pcsvReader getValue:COL_OI_MIN_ROLL] floatValue];
	CGFloat maxRoll = [[pcsvReader getValue:COL_OI_MAX_ROLL] floatValue];
	
	OrientationImage *orientationImage = [[OrientationImage alloc] initOrientationImage:imageId withMinYaw:minYaw withMaxYaw:maxYaw withMinPitch:minPitch withMaxPitch:maxPitch withMinRoll:minRoll withMaxRoll:maxRoll];
	[orientationImages addObject:orientationImage];
}
@end
