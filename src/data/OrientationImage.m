//
//  OrientationImage.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/28/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

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
	[super init];
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
