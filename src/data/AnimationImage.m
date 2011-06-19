//
//  AnimationImage.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/20/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import "AnimationImage.h"


@implementation AnimationImage
@synthesize imageId;
@synthesize duration;
-(AnimationImage*) initAnimationImage:(NSString*)pimageId withDuration:(float) pduration{
	[super init];
	if(self)
	{
		imageId = [pimageId retain];
		duration=pduration;
	}
	return self;
}

- (NSString *)description{
	return [NSString stringWithFormat:@"%@: %@(%f)",
			NSStringFromClass(self.class),imageId,duration];
}	

@end
