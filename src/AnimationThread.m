//
//  AnimationThread.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimationThread.h"
#import "data/AnimationImage.h"
#import "Nounours.h"

@implementation AnimationThread
@synthesize isRunning;

-(AnimationThread*) initAnimationThread:(Nounours*) pnounours withAnimation:(Animation*) panimation{
	[self initWithTarget:self selector:@selector(doAnimation:) object:panimation];
	if(self){
		nounours = pnounours;
		isRunning = NO;
	}
	return self;
}
-(void) doAnimation:(Animation*) panimation{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSArray *animationImages = [panimation images];
	isRunning = YES;
	[nounours debug:[NSString stringWithFormat:@"Doing animation %@ - %@",panimation.uid,panimation.label]];
	for(int i=0; i < panimation.repeat; i++)
	{
		for(AnimationImage *animationImage in animationImages)
		{
			if([self isCancelled])
				break;
			[self performSelectorOnMainThread:@selector(displayImage:) withObject:animationImage.imageId waitUntilDone:YES];
			CGFloat frameDuration = (CGFloat) (panimation.interval * animationImage.duration)/1000.0;
			[nounours debug:[NSString stringWithFormat:@"%@:isRunning=%s%d*%.2f=%.2f",animationImage.imageId,[self isExecuting]? "true":"false",panimation.interval,animationImage.duration,frameDuration]];
			[NSThread sleepForTimeInterval:frameDuration];
			
		}
		if([self isCancelled])
			break;
	}
	isRunning = NO;
	[pool release];
}
-(void) stopAnimation{
	[super cancel];
}

-(void) displayImage:(id)pimageId{
	NSString* imageId = (NSString*) pimageId;
	[nounours setImageWithImageId:imageId];
}
@end
