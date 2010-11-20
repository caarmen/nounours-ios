//
//  Animation.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Animation.h"
#import "AnimationImage.h"

@implementation Animation
@synthesize images;
@synthesize uid;
@synthesize label;
@synthesize interval;
@synthesize repeat;
@synthesize visible;
@synthesize vibrate;
@synthesize soundId;

-(Animation*) initAnimation:(NSString *)puid withLabel:(NSString*) plabel withInterval:(int) pinterval withRepeat:(int) prepeat withVisible:(BOOL) pvisible withVibrate:(BOOL) pvibrate 
withSoundId:(NSString*) psoundId{
	[super init];
	if(self)
	{
		uid = puid;
		label = plabel;
		interval = pinterval;
		repeat = prepeat;
		visible = pvisible;
		vibrate = pvisible;
		soundId = psoundId;
		images = [[NSArray alloc] init];
	}
	return self;
}

-(void) addImage:(NSString*)pimageId withDuration:(float)pduration{
	AnimationImage *image = [[AnimationImage alloc] initAnimationImage:pimageId withDuration:pduration];
	[images addObject:image];
}
-(long) getDuration{
	int duration = 0;
	for(AnimationImage *image in images)
	{
		duration += [image duration]*interval;
	}
	return duration * repeat;
}
-(Animation*) clone{
	Animation *dup = [[Animation alloc] initAnimation:uid withLabel:label withInterval:interval withRepeat:repeat withVisible:visible withVibrate:vibrate withSoundId:soundId];
	for(AnimationImage *image in images)
	{
		[dup addImage:image.imageId withDuration:image.duration];
	}
	return dup;
}
- (NSString *)description{
	return [NSString stringWithFormat:@"%@: %@ms %d times: %@",
			NSStringFromClass(self.class),interval, repeat, images];
}



@end
