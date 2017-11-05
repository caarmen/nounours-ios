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

#import <CoreGraphics/CoreGraphics.h>
#import "FlingAnimationReader.h"
#import "FlingAnimation.h"

NSString * const COL_FLING_ANIMATION_ID = @"Id";
NSString * const COL_FLING_ANIMATION_X = @"X";
NSString * const COL_FLING_ANIMATION_Y = @"Y";
NSString * const COL_FLING_ANIMATION_WIDTH = @"Width";
NSString * const COL_FLING_ANIMATION_HEIGHT = @"Height";
NSString * const COL_FLING_ANIMATION_MIN_VEL_X = @"MinVelX";
NSString * const COL_FLING_ANIMATION_MIN_VEL_Y = @"MinVelY";
NSString * const COL_FLING_ANIMATION_ANIMATION_ID = @"AnimationId";
NSString * const COL_FLING_ANIMATION_VARIABLE_SPEED = @"VariableSpeed";

@implementation FlingAnimationReader
@synthesize flingAnimations;

-(FlingAnimationReader*) initFlingAnimationReader:(NSString*)pfilename{
	self = [super initNounoursReader:pfilename];
	if(self)
	{
		flingAnimations = [[NSMutableArray alloc] init];
		[self load];
	}
	return self;
}
-(void) readLine:(CSVReader*) pcsvReader{
	NSString *uid = [pcsvReader getValue:COL_FLING_ANIMATION_ID];
	CGFloat x = [[pcsvReader getValue:COL_FLING_ANIMATION_X] floatValue];
	CGFloat y = [[pcsvReader getValue:COL_FLING_ANIMATION_Y] floatValue];
	CGFloat width = [[pcsvReader getValue:COL_FLING_ANIMATION_WIDTH] floatValue];
	CGFloat height = [[pcsvReader getValue:COL_FLING_ANIMATION_HEIGHT] floatValue];
	CGFloat minVelX = [[pcsvReader getValue:COL_FLING_ANIMATION_MIN_VEL_X] floatValue];
	CGFloat minVelY = [[pcsvReader getValue:COL_FLING_ANIMATION_MIN_VEL_Y] floatValue];
    NSString *animationId = [pcsvReader getValue:COL_FLING_ANIMATION_ANIMATION_ID];
	BOOL variableSpeed = [[pcsvReader getValue:COL_FLING_ANIMATION_VARIABLE_SPEED] boolValue];
	FlingAnimation *flingAnimation = [[FlingAnimation alloc] initFlingAnimation:uid withX:x withY:y withWidth:width withHeight:height withMinVelX:minVelX withMinVelY:minVelY withAnimationId:animationId withVariableSpeed:variableSpeed];
	[flingAnimations addObject:flingAnimation];
}
@end
