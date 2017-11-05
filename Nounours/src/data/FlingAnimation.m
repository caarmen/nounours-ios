//
//  FlingAnimation.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/20/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
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
