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

#import "AnimationHandler.h"
#import "data/AnimationImage.h"
#import "data/Image.h"
#import "data/Animation.h"
#import "Nounours.h"

@implementation AnimationHandler

-(AnimationHandler*) initAnimationHandler:(Nounours*) pnounours{
	self = [super init];
	if(self)
	{
		nounours = pnounours;
		curAnimationDuration = -1.0f;
		timeLastAnimationLaunched = -1.0f;
	}
	return self;
}
-(void) stopAnimation{
	[nounours.mainView stopAnimating];
	curAnimationDuration = -1.0f;
	timeLastAnimationLaunched = -1.0f;
}
-(BOOL) isAnimationRunning{
	if((![nounours.mainView isAnimating]) || curAnimationDuration <0 || timeLastAnimationLaunched < 0)
		return NO;
	else{
		NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
		NSTimeInterval timeSinceAnimationLaunched = now - timeLastAnimationLaunched;
		NSLog(@"%.2f - %.2f = %.2f: %.2f ",now, timeLastAnimationLaunched, timeSinceAnimationLaunched, curAnimationDuration);
		if(timeSinceAnimationLaunched < curAnimationDuration)
			return YES;
		else {
			return NO;
		}

	}
}
-(void) doAnimation:(Animation*) panimation{
	[self stopAnimation];
	[self performSelectorInBackground:@selector(doAnimationImpl:) withObject:panimation];
}
-(void) doAnimationImpl:(Animation*) panimation{

    NSMutableArray *animationArray;
    @autoreleasepool {
        CGFloat baseFrameDuration = 1.0f/30;
        animationArray = [[NSMutableArray alloc] init];
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
        if(panimation.vibrate && nounours.doVibrate)
        {
            [nounours.vibrateHandler doVibrate:[panimation getDuration] withInterval:1];
        }
        nounours.mainView.animationImages = animationArray;
        nounours.mainView.animationRepeatCount = panimation.repeat;
        CGFloat oneLoopAnimationDuration =  baseFrameDuration * [animationArray count];
        nounours.mainView.animationDuration = oneLoopAnimationDuration;
        [nounours.mainView performSelectorOnMainThread:@selector(startAnimating) withObject:nil waitUntilDone:NO];
        timeLastAnimationLaunched = [NSDate timeIntervalSinceReferenceDate];
        curAnimationDuration = [panimation getDuration] / 1000.0f;
        NSLog(@"launched animation of %.2f seconds", curAnimationDuration);
    }
}

@end
