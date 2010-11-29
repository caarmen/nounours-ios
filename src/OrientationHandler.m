//
//  OrientationHandler.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OrientationHandler.h"
#import "data/OrientationImage.h"
#import "data/Image.h"

@implementation OrientationHandler
-(OrientationHandler*) initOrientationHandler:(Nounours*) pnounours{
	[super init];
	nounours = pnounours;
	CMMotionManager *motionManager = [[CMMotionManager alloc] init];
	motionManager.accelerometerUpdateInterval = 0.5f;
	if(!motionManager.isDeviceMotionAvailable)
	{
		NSLog(@"No device motion available");
	}
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	CMAccelerometerHandler motionHandler = Block_copy(^(CMAccelerometerData *accelerometerData, NSError *error) {
		NSLog(@"motion handler");
		[self performSelectorOnMainThread:@selector(doDeviceMotion:) withObject:accelerometerData waitUntilDone:NO];
	});
	[motionManager startAccelerometerUpdatesToQueue:queue withHandler:motionHandler]; 
	NSLog(@"Registered for motion events");
	isTiltImage = NO;
	return self;
}
-(void) doDeviceMotion:(CMAccelerometerData*) accelerometerData{
	CMAcceleration acceleration = accelerometerData.acceleration;
	CGFloat accelX = acceleration.x;
	CGFloat accelY = acceleration.y;
	if(accelX > 1.0f)
		accelX = 1.0f;
	if(accelX < -1.0f)
		accelX = -1.0f;
	if(accelY > 1.0f)
		accelY = 1.0f;
	if(accelY < -1.0f)
		accelY = -1.0f;
	
	CGFloat pitch = asin(accelY)*180/M_PI;
	CGFloat roll = asin(accelX)*180/M_PI;
//	NSLog(@"accel: %0.2f,%0.2f,%0.2f",acceleration.x,acceleration.y,acceleration.z);
//	NSLog(@"pitch: %0.2f, roll=%0.2f",pitch,roll);
	
	
	for(OrientationImage *orientationImage in nounours.curTheme.orientationImages)
	{
		if(pitch >= orientationImage.minPitch && pitch <= orientationImage.maxPitch
		   && roll >= orientationImage.minRoll && roll <= orientationImage.maxRoll)
		{
			Image *image = [nounours.curTheme.images objectForKey:orientationImage.imageId];
			[nounours stopAnimation];
			[nounours setImage:image];
			isTiltImage = YES;
			return;
		}
	}
	if(isTiltImage)
	{
		[nounours setImage:nounours.curTheme.defaultImage];
		isTiltImage = NO;
	}
}
@end