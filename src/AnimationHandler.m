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
	[nounours.mainView stopAnimating];
}
-(BOOL) isAnimationRunning{
	return [nounours.mainView isAnimating];
}
-(void) doAnimation:(Animation*) panimation{
	[self stopAnimation];
	[self performSelectorInBackground:@selector(doAnimationImpl:) withObject:panimation];
}
-(void) doAnimationImpl:(Animation*) panimation{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	CGFloat baseFrameDuration = 1.0f/30;
	NSMutableArray *animationArray = [[NSMutableArray alloc] init];
	NSArray *animationImages = [panimation images];
	for(AnimationImage *animationImage in animationImages)
	{
		CGFloat frameDuration = (CGFloat) (panimation.interval * animationImage.duration)/1000.0;
		NSInteger frameRepeat = frameDuration / baseFrameDuration;
		Image *image = [nounours.curTheme.images objectForKey:animationImage.imageId];
		UIImage *uiImage = [nounours.mainView.imageCache objectForKey:image.filename];
		if(uiImage == nil)
			NSLog(@"Can't find animation image %@: %@",animationImage.imageId,image);
		else {
			for(int j=0; j<frameRepeat; j++)
			{
				[animationArray addObject:uiImage];
			}
		}

	}
	nounours.mainView.animationImages = animationArray;
	nounours.mainView.animationRepeatCount = panimation.repeat;
	nounours.mainView.animationDuration = baseFrameDuration * [animationArray count];
	[nounours.mainView performSelectorOnMainThread:@selector(startAnimating) withObject:nil waitUntilDone:NO];
	NSLog(@"launched animation");
	[animationArray release];
	[pool release];
}

@end
