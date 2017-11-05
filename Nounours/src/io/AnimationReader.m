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

#import "AnimationReader.h"
#import "Animation.h"

NSString * const COL_ANIMATION_ID = @"Id";
NSString * const COL_ANIMATION_LABEL = @"Label";
NSString * const COL_ANIMATION_INTERVAL = @"Interval";
NSString * const COL_ANIMATION_SEQUENCE = @"Sequence";
NSString * const COL_ANIMATION_REPEAT = @"Repeat";
NSString * const COL_ANIMATION_VISIBLE = @"Visible";
NSString * const COL_ANIMATION_VIBRATE = @"Vibrate";
NSString * const COL_ANIMATION_SOUND = @"Sound";


@implementation AnimationReader
@synthesize animations;
-(AnimationReader*) initAnimationReader:(NSString*) pfileName{
	self = [super initNounoursReader:pfileName];
	if(self)
	{
		animations = [[NSMutableDictionary alloc] init];
		[self load];
	}
	return self;
}
-(void) readLine:(CSVReader*) pcsvReader{
	NSString* uid = [pcsvReader getValue:COL_ANIMATION_ID];
	NSString* labelId = [pcsvReader getValue:COL_ANIMATION_LABEL];
	NSString* label = NSLocalizedString(labelId,@"");
	int interval = [[pcsvReader getValue:COL_ANIMATION_INTERVAL] intValue];
	int repeat = [[pcsvReader getValue:COL_ANIMATION_REPEAT] intValue];
	BOOL visible = [[pcsvReader getValue:COL_ANIMATION_VISIBLE] boolValue];
	BOOL vibrate = [[pcsvReader getValue:COL_ANIMATION_VIBRATE] boolValue];
	NSString* soundId = [pcsvReader getValue:COL_ANIMATION_SOUND];
	NSString* sequenceStr = [pcsvReader getValue:COL_ANIMATION_SEQUENCE];
	NSArray *sequence = [sequenceStr componentsSeparatedByString:@";"];
    Animation *animation = [[Animation alloc] initAnimation:uid withLabel:label withInterval:interval withRepeat:repeat withVisible:visible withVibrate:vibrate withSoundId:soundId];
	float duration = 1.0;
	for(NSString* imageId in sequence)
	{
		if([imageId hasPrefix:@"d="])
		{
			duration = [[imageId substringFromIndex:2]floatValue];
		}
		else
			[animation addImage:imageId withDuration:duration];
	}
	[animations setObject:animation forKey:uid];
	
}
@end
