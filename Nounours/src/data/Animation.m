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
	self = [super init];
	if(self)
	{
		uid = puid;
		label = plabel;
		interval = pinterval;
		repeat = prepeat;
		visible = pvisible;
		vibrate = pvibrate;
		soundId = psoundId;
		images = [[NSMutableArray alloc] init];
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
	return [NSString stringWithFormat:@"%@: %@: %dms %d times: %@",
			NSStringFromClass(self.class),uid,interval, repeat, images];
}



@end
