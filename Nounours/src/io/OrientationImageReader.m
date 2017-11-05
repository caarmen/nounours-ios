//
// Copyright (c) 2010 - 2011 Carmen Alvarez
//
// This file is part of Nounours for iOS.
//
// Nounours for iOS is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Nounours for iOS is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Nounours for iOS.  If not, see <http://www.gnu.org/licenses/>.
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
