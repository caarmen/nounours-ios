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

	[nounours debug:[NSString stringWithFormat:@"isRunning? %s",animationThread.isRunning? "yes" : "no"]];
	[animationThread stopAnimation];
	while([animationThread isRunning])
	{
		[NSThread sleepForTimeInterval:0.1];
	}
	[nounours debug:[NSString stringWithFormat:@"isRunning now? %s",animationThread.isRunning? "yes" : "no"]];
	[animationThread release];
	animationThread = nil;	
	
}
-(BOOL) isAnimationRunning{
	
	if(animationThread == nil)
		return NO;
	return animationThread.isRunning;
}
-(void) doAnimation:(Animation*) panimation{
	[self stopAnimation];
	animationThread = [[AnimationThread alloc]initAnimationThread:nounours withAnimation:panimation];
	[animationThread start];
}

@end
