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
#import "VibrateHandler.h"

@implementation AnimationThread
@synthesize isRunning;

-(AnimationThread*) initAnimationThread:(Nounours*) pnounours withAnimation:(Animation*) panimation{
	[self initWithTarget:self selector:@selector(doAnimation:) object:panimation];
	if(self){
		nounours = pnounours;
	}
	return self;
}
-(void) doAnimation:(Animation*) panimation{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSArray *animationImages = [panimation images];
	[nounours debug:[NSString stringWithFormat:@"Doing animation %@ - %@",panimation.uid,panimation.label]];
	if(panimation.vibrate)
	{
		[nounours.vibrateHandler doVibrate:[panimation getDuration] withInterval:1];
	}
//	CGFloat delay = 0.5f;
	CGFloat baseFrameDuration = 1.0f/15;
	NSMutableArray *animationArray = [[NSMutableArray alloc] init];
	//for(int i=0; i < panimation.repeat; i++)
	//{
		for(AnimationImage *animationImage in animationImages)
		{
			
			//if([self isCancelled])
			//	break;
			//[self performSelector:@selector(displayImage:) withObject:animationImage.imageId afterDelay:delay /*inModes:[[NSArray alloc]initWithObjects:NSRunLoopCommonModes,nil]*/];
			CGFloat frameDuration = (CGFloat) (panimation.interval * animationImage.duration)/1000.0;
			NSInteger frameRepeat = frameDuration / baseFrameDuration;
			Image *image = [nounours.curTheme.images objectForKey:animationImage.imageId];
			UIImage *uiImage = [nounours.mainView.imageCache objectForKey:image.filename];
			for(int j=0; j<frameRepeat; j++)
			{
				[animationArray addObject:uiImage];
			}
			/*delay += frameDuration;
			[nounours debug:[NSString stringWithFormat:@"%@:isRunning=%s%d*%.2f=%.2f, delay:%0.2f",animationImage.imageId,[self isExecuting]? "true":"false",panimation.interval,animationImage.duration,frameDuration,delay]];
			//			[self performSelectorOnMainThread:@selector(displayImage:) withObject:animationImage.imageId waitUntilDone:NO];
			//			[NSThread sleepForTimeInterval:frameDuration];
			 */
			
		}
	//	if([self isCancelled])
	//		break;
	//}
	nounours.mainView.animationImages = animationArray;
	nounours.mainView.animationRepeatCount = panimation.repeat;
	nounours.mainView.animationDuration = baseFrameDuration * [animationArray count];
	[nounours.mainView performSelectorOnMainThread:@selector(startAnimating) withObject:nil waitUntilDone:NO];
	[animationArray release];
	/*
	[self performSelector:@selector(displayImage:) withObject:nounours.curTheme.defaultImage.uid afterDelay:delay];
	NSLog(@"Waiting...");
	BOOL done = NO;
    do
    {
		
        // Start the run loop but return after each source is handled.
        SInt32    result = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1, YES);
		NSLog(@"Executing: %s, Cancelled: %s, Finished: %s", [self isExecuting]? "yes":"no",[self isCancelled]? "yes":"no",[self isFinished]? "yes":"no");
		
        // If a source explicitly stopped the run loop, or if there are no
        // sources or timers, go ahead and exit.
        if ((result == kCFRunLoopRunStopped) || (result == kCFRunLoopRunFinished)|| ([self isCancelled]))
            done = YES;
    }
    while (!done);
	NSLog(@"done");
	NSLog(@"Executing: %s, Cancelled: %s, Finished: %s", [self isExecuting]? "yes":"no",[self isCancelled]? "yes":"no",[self isFinished]? "yes":"no");
*/
	[pool release];
}
-(void) stopAnimation{
	[super cancel];
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	
}

-(void) displayImage:(id)pimageId{
	if([self isCancelled] || [self isFinished])
		return;
	[nounours performSelectorOnMainThread:@selector(setImageWithImageId:) withObject:pimageId waitUntilDone:YES];
}
@end
