//
//  AnimationHandler.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimationHandler.h"
#import "data/AnimationImage.h"
#import "data/Image.h"
#import "data/Animation.h"
#import "Nounours.h"

@implementation AnimationHandler
-(AnimationHandler*) initAnimationHandler:(Nounours*) pnounours{
	[super init];
	if(self)
	{
		nounours = pnounours;
	}
	return self;
}
-(void) stopAnimation{
	if(animationThread == nil)
		return;
	[animationThread cancel];
}
-(BOOL) isAnimationRunning{
	
	if(animationThread == nil)
		return NO;
	if([animationThread isExecuting])
		return YES;
	return NO;
}
-(void) doAnimation:(Animation*) panimation{
	if(animationThread != nil)
	{
		[animationThread cancel];
		while(![animationThread isCancelled])
		{
			[NSThread sleepForTimeInterval:1.0];
		}
		[animationThread release];
	}
	animationThread = [[NSThread alloc] initWithTarget:self selector:@selector(doAnimationImpl:) object:panimation];
	[animationThread start];
}
-(void) doAnimationImpl:(Animation*) panimation{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSArray *animationImages = [panimation images];
	[nounours debug:[NSString stringWithFormat:@"Doing animation %@",panimation.uid]];
	for(AnimationImage *animationImage in animationImages)
	{
//		NSString *imageId = [animationImage imageId];
		[nounours setImageWithImageId:animationImage.imageId];
		CGFloat frameDuration = (CGFloat) (panimation.interval * animationImage.duration)/1000.0;
		[nounours debug:[NSString stringWithFormat:@"%@:%f*%f=%f",animationImage.imageId,panimation.interval,animationImage.duration,frameDuration]];
		[NSThread sleepForTimeInterval:frameDuration];
		
	}
	[pool release];
}
@end
