//
//  AnimationReader.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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
	[super initNounoursReader:pfileName];
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
	Animation *animation = [[[Animation alloc] initAnimation:uid withLabel:label withInterval:interval withRepeat:repeat withVisible:visible withVibrate:vibrate withSoundId:soundId] retain];
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
