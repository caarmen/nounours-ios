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

#import <CoreGraphics/CoreGraphics.h>
#import "OrientationImage.h"


@implementation OrientationImage
@synthesize imageId;
@synthesize minYaw;
@synthesize maxYaw;
@synthesize minPitch;
@synthesize maxPitch;
@synthesize minRoll;
@synthesize maxRoll;

-(OrientationImage*) initOrientationImage:(NSString*) pimageId withMinYaw:(CGFloat) pminYaw withMaxYaw:(CGFloat) pmaxYaw withMinPitch:(CGFloat) pminPitch withMaxPitch:(CGFloat) pmaxPitch withMinRoll:(CGFloat) pminRoll withMaxRoll:(CGFloat) pmaxRoll{
	self = [super init];
	imageId = pimageId;
	minYaw = pminYaw;
	maxYaw = pmaxYaw;
	minPitch = pminPitch;
	maxPitch = pmaxPitch;
	minRoll = pminRoll;
	maxRoll = pmaxRoll;
	return self;
}
-(NSString*) description{
	return [NSString stringWithFormat:@"Orientation: %@, Yaw between %f and %f, pitch between %f and %f, roll between %f and %f", imageId, minYaw, maxYaw, minPitch, maxPitch, minRoll, maxRoll]; 
}
@end
