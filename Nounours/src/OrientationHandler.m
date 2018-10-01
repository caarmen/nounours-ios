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

#import "OrientationHandler.h"
#import "data/OrientationImage.h"
#import "data/Image.h"
#import <CoreMotion/CoreMotion.h>
#import "Nounours-Swift.h"
@implementation OrientationHandler
-(OrientationHandler*) initOrientationHandler:(Nounours*) pnounours{
	self =[super init];
	nounours = pnounours;
	isTiltImage = NO;
	return self;
}
- (void)subscribeToAccelerometer {
	CMMotionManager *motionManager = [CMMotionManagerInstance shared];
	if (motionManager.accelerometerAvailable) {
		motionManager.accelerometerUpdateInterval = 0.5f;
		[motionManager startAccelerometerUpdatesToQueue:NSOperationQueue.mainQueue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error){
			if (accelerometerData != nil) {
				[self didAccelerate:accelerometerData.acceleration];
			}
		}];
		NSLog(@"Registered for motion events");
	} else {
		NSLog(@"Accelerometer not available to register");
	}
}
- (void)unsubscribeToAccelerometer {
	CMMotionManager *motionManager = [CMMotionManagerInstance shared];
	if (motionManager.accelerometerAvailable) {
		[motionManager stopAccelerometerUpdates];
		NSLog(@"Unregistered for motion events");
	} else {
		NSLog(@"Accelerometer not available to unregister");
	}
}
- (void)didAccelerate:(CMAcceleration)acceleration{
	
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
