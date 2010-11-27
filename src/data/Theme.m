//
//  Theme.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Theme.h"
#import "../io/PropertiesReader.h"
#import "../io/FeatureReader.h"
#import "../io/ImageReader.h"
#import "../io/SoundReader.h"
#import "../io/ImageFeatureReader.h"
#import "../io/AdjacentImageReader.h"
#import "../io/AnimationReader.h"
#import "../io/FlingAnimationReader.h"

@implementation Theme
NSString * const PROP_SHAKE_ANIMATION = @"animation.shake";
NSString * const PROP_RESUME_ANIMATION = @"animation.resume";
NSString * const PROP_IDLE_ANIMATION = @"animation.idle";
NSString * const PROP_END_IDLE_ANIMATION = @"animation.idle.end";
NSString * const PROP_HELP_IMAGE = @"help.image";
NSString * const PROP_DEFAULT_IMAGE = @"default.image";
NSString * const PROP_HEIGHT = @"resolution.height";
NSString * const PROP_WIDTH = @"resolution.width";
@synthesize height;
@synthesize width;
@synthesize uid;
@synthesize name;
//@synthesize location

@synthesize images;
@synthesize animations;
@synthesize sounds;
@synthesize flingAnimations;
@synthesize shakeAnimation;
@synthesize resumeAnimation;
@synthesize idleAnimation;
@synthesize endIdleAnimation;
@synthesize helpImage;
@synthesize defaultImage;
@synthesize isLoaded;
-(Theme*) initTheme:(NSString*) puid withName:(NSString*) pname /*withLocation(NSString*) plocation*/{
	[super init];
	uid = puid;
	name = pname;
	isLoaded = NO;
 //   NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
	return self;
}
-(void) load:(Nounours*) pnounours {
	if(isLoaded)
		return;
	//location = plocation;
	NSString *propertiesPath = [self getPath:@"nounours.properties"];//[NSString stringWithFormat:@"%@/themes/%@/nounours.properties",bundlePath,uid];
	PropertiesReader *propReader = [[PropertiesReader alloc] initPropertiesReader:propertiesPath];
	properties = [propReader.data retain];
	
	NSString *shakeAnimationId = [properties objectForKey:PROP_SHAKE_ANIMATION];
	NSString *resumeAnimationId = [properties objectForKey:PROP_RESUME_ANIMATION];
	NSString *idleAnimationId = [properties objectForKey:PROP_IDLE_ANIMATION];
	NSString *endIdleAnimationId = [properties objectForKey:PROP_END_IDLE_ANIMATION];
	NSString *helpImageId = [properties objectForKey:PROP_HELP_IMAGE];
	NSString *defaultImageId = [properties objectForKey:PROP_DEFAULT_IMAGE];
	
	height = [[properties objectForKey:PROP_HEIGHT] floatValue];
	width = [[properties objectForKey:PROP_WIDTH] floatValue];

	FeatureReader *featureReader = [[FeatureReader alloc] initFeatureReader:[self getPath:@"feature.csv"]];
	
	ImageReader *imageReader = [[ImageReader alloc] initImageReader:[self getPath:@"image.csv"]];
	images = imageReader.images;
	SoundReader *soundReader = [[SoundReader alloc] initSoundReader:[self getPath:@"sound.csv"]];
	sounds = soundReader.sounds;
	
	[[ImageFeatureReader alloc] initImageFeatureReader:images andFeatures:featureReader.features andFilename:[self getPath:@"imagefeatureassoc.csv"]];
	[[AdjacentImageReader alloc] initAdjacentImageReader:images andFilename:[self getPath:@"adjacentimage.csv"]];
	
	AnimationReader *animationReader = [[AnimationReader alloc] initAnimationReader:[self getPath:@"animation.csv"]];
	animations = animationReader.animations;
	
	for(Animation *animation in [animations allValues])
	{
		if(shakeAnimationId != nil && [animation.uid isEqualToString:shakeAnimationId])
			shakeAnimation = animation;
		if(resumeAnimationId != nil && [animation.uid isEqualToString:resumeAnimationId])
			resumeAnimation = animation;
		if(idleAnimationId != nil && [animation.uid isEqualToString:idleAnimationId])
			idleAnimation = animation;
		if(endIdleAnimationId != nil && [animation.uid isEqualToString:endIdleAnimationId])
			endIdleAnimation = animation;
	}
	
	FlingAnimationReader *flingAnimationReader = [[FlingAnimationReader alloc] initFlingAnimationReader:[self getPath:@"flinganimation.csv"]];
	flingAnimations = flingAnimationReader.flingAnimations;
	
	for(Image *image in [images allValues])
	{
		if([image.uid isEqualToString:defaultImageId])
			defaultImage = image;
		else if ([image.uid isEqualToString:helpImageId])
			helpImage = image;
	}
	isLoaded = YES;	
}
-(NSString*) description{
	return [NSString stringWithFormat:@"%@,%@,%@",uid,name/*,location*/];
}
-(NSString*) getPath:(NSString*) pfilename{
    NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
	NSString *path = [NSString stringWithFormat:@"%@/themes/%@/data/%@",bundlePath,uid,pfilename];
	return path;
}
@end
