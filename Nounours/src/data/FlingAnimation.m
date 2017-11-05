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

#import "FlingAnimation.h"


@implementation FlingAnimation
@synthesize uid;
@synthesize x;
@synthesize y;
@synthesize width;
@synthesize height;
@synthesize minVelX;
@synthesize minVelY;
@synthesize animationId;
@synthesize variableSpeed;

-(FlingAnimation*) initFlingAnimation:(NSString*) puid withX:(CGFloat) px withY:(CGFloat) py withWidth:(CGFloat) pwidth withHeight:(CGFloat) pheight withMinVelX:(CGFloat)pminVelX withMinVelY:(CGFloat)pminVelY withAnimationId:(NSString*) panimationId withVariableSpeed:(BOOL) pvariableSpeed{
	self = [super init];
	if(self)
	{
		uid = puid;
		x = px;
		y = py;
		width = pwidth;
		height = pheight;
		minVelX = pminVelX;
		minVelY = pminVelY;
		animationId = panimationId;
		variableSpeed = pvariableSpeed;
	}
	return self;
}

@end
