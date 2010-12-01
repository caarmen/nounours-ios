//
//  Nounours.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Nounours.h"
#import "Util.h"
#import "Feature.h";
#import "FeatureReader.h";
#import "ImageReader.h";
#import "ImageFeatureReader.h"
#import "AdjacentImageReader.h"
#import "AnimationReader.h"
#import "FlingAnimationReader.h"
#import "Image.h"
#import "Animation.h"
#import "Sound.h"
#import "Theme.h"
#import "io/SoundReader.h"
#import "io/ThemeReader.h"

@implementation Nounours
@synthesize defaultImage;
@synthesize curTheme;
@synthesize themes;
@synthesize vibrateHandler;
@synthesize mainView;

-(Nounours*) initNounours:(MainView*) pmainView{
	[super init];
	if(self)
	{
		isLoading = YES;
		lastActionTimestamp = -1.0;
		curAnimation = nil;
		curImage = nil;
		NSString *themesFile = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"csv"];
		NSLog(@"Reading themes..." );
		ThemeReader *themeReader = [[ThemeReader alloc] initThemeReader:themesFile];
		NSLog(@"Read themes.");
		themes = themeReader.themes;
		Theme *initialTheme = [[themes allValues] objectAtIndex:0];
		[initialTheme load:self];
		
		idleTimeout = [Util getTimeIntervalProperty:initialTheme.properties withKey:@"idle.time" withDefaultValue:60.0f];
		pingInterval = [Util getTimeIntervalProperty:initialTheme.properties withKey:@"idle.ping.interval" withDefaultValue:5.0f];
		
		mainView = pmainView;
		mainView.nounours = self;
		[mainView setImageFromFilename:initialTheme.defaultImage.filename];
		soundHandler = [[SoundHandler alloc] initSoundHandler];
		animationHandler = [[AnimationHandler alloc] initAnimationHandler:self];
		vibrateHandler = [[VibrateHandler alloc] initVibrateHandler];
		orientationHandler = [[OrientationHandler alloc] initOrientationHandler:self];
		UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onFling:)];
		[mainView addGestureRecognizer:panRecognizer];
		[self performSelectorOnMainThread:@selector(useTheme:) withObject:initialTheme.uid waitUntilDone:NO];
		
		[self resetIdle];
		nounoursIdlePinger = [[NounoursIdlePinger alloc] initNounoursIdlePinger:self withPingInterval:pingInterval];
		[nounoursIdlePinger performSelectorInBackground:@selector(run:) withObject:nil];
		
	}
	return self;
}

-(CGFloat) getDeviceWidth{
	CGRect rect = [[UIScreen mainScreen] bounds] ;
	return rect.size.width;
}
-(CGFloat) getDeviceHeight{
	CGRect rect = [[UIScreen mainScreen] bounds] ;
	return rect.size.height;
}

-(void) displayImage:(Image*)pimage{
	[mainView setImageFromFilename:[pimage filename]];
}

-(void) onPress:(CGFloat)px withY:(CGFloat)py{
	lastLocation.x = px;
	lastLocation.y = py;
	BOOL wasIdle = ([animationHandler isAnimationRunning] && curAnimation != nil
					&& curAnimation == curTheme.idleAnimation);
	[self stopAnimation];
	CGSize imageSize = [mainView getImageSize];
	CGPoint translatedPoint = [Util translate:px withDeviceY:py withDeviceWidth:[self getDeviceWidth] withDeviceHeight:[self getDeviceHeight] withImageWidth:imageSize.width withImageHeight:imageSize.height];
	//[self debug:[NSString stringWithFormat:@"onPress %f,%f=>%f,%f",px,py,translatedPoint.x,translatedPoint.y]];
	
	if(curImage == nil)
		return;
 	
	if(wasIdle && curTheme.endIdleAnimation != nil)
	{
		[self doAnimation:curTheme.endIdleAnimation.uid];
	}
	else
	{
		curFeature = [Util getClosestFeature:curImage withX:translatedPoint.x withY:translatedPoint.y];
		if(curFeature != nil)
		{
			//[self debug:[NSString stringWithFormat:@"clicked on feature %@",curFeature]];
			NSSet *adjacentImages = [curImage getAdjacentImages:curFeature.uid];
			if([adjacentImages count] == 0)
			{
				curImage = defaultImage;
			}
		}
	}
	[self resetIdle];
	
}
-(void) onRelease{
	[self resetIdle];
	curFeature = nil;
	[self debug:@"onRelease"];
	if(curImage != nil)
	{
		NSString *nextImageId = curImage.onReleaseImageId;
		if(nextImageId != nil)
		{
			Image *nextImage = [curTheme.images objectForKey:nextImageId];
			[self setImage:nextImage];
			[vibrateHandler doVibrate:nil];
		}
	}
	lastLocation.x=-1;
	lastLocation.y=-1;
	
}
-(void) onMove:(CGFloat)px withY:(CGFloat)py{
	BOOL doRefresh = YES;
	CGSize imageSize = [mainView getImageSize];
	CGPoint translatedPoint = [Util translate:px withDeviceY:py withDeviceWidth:[self getDeviceWidth] withDeviceHeight:[self getDeviceHeight] withImageWidth:imageSize.width withImageHeight:imageSize.height];
	if(curFeature != nil)
	{
		Image *image = [Util getAdjacentImage:curImage withFeatureId:curFeature.uid withX:translatedPoint.x withY:translatedPoint.y];
		if(image != nil)
		{
			if(curImage != nil && [curImage.uid isEqualToString:image.uid])
			{
				doRefresh = NO;
			}
			curImage = image;
		}
	}
	if(curImage == nil)
		curImage = curTheme.defaultImage;
	if(doRefresh)
		[self displayImage:curImage];
}

-(void) onFling:(UIPanGestureRecognizer*) pgestureRecognizer{
	CGPoint location = [pgestureRecognizer locationInView:mainView];
	CGPoint velocity = [pgestureRecognizer velocityInView:mainView];
	if(pgestureRecognizer.state == UIGestureRecognizerStateEnded)
	{
		CGPoint translatedPoint = [Util translate:lastLocation.x withDeviceY:lastLocation.y withDeviceWidth:[self getDeviceWidth] withDeviceHeight:[self getDeviceHeight] withImageWidth:[mainView getImageSize].width withImageHeight:[mainView getImageSize].height]; 
		[self debug:[NSString stringWithFormat:@"onFling:Pan started at (%f,%f). %velocity:(%f,%f)",translatedPoint.x,translatedPoint.y, velocity.x, velocity.y]];
		for(FlingAnimation* flingAnimation in curTheme.flingAnimations )
		{
			[self debug:[NSString stringWithFormat:@"testing %@",flingAnimation.animationId]];
			if(![Util isFaster:velocity.x withV2:flingAnimation.minVelX])
			{
				continue;
			}
			if(![Util isFaster:velocity.y withV2:flingAnimation.minVelY]){
				continue;
			}
			if(![Util pointIsInSquare:translatedPoint.x withPointY:translatedPoint.y withSquareX:flingAnimation.x withSquareY:flingAnimation.y withSquareWidth:flingAnimation.width withSquareHeight:flingAnimation.height])
			{
				continue;
			}
			Animation* animation = [curTheme.animations objectForKey:flingAnimation.animationId];
			[self doAnimation:animation.uid];
			
		}
		if(!animationHandler.isAnimationRunning)
			[self onRelease];
		
	}
	else if(pgestureRecognizer.state == UIGestureRecognizerStateChanged) {
		[self onMove:location.x withY:location.y];
	}
	
}
-(void) onShake{
	if(curTheme.shakeAnimation != nil)
		[self doAnimation:curTheme.shakeAnimation.uid];
}

-(void) doAnimation:(NSString *)panimationId{
	Animation *animation = [curTheme.animations objectForKey:panimationId];
	[self doAnimation:animation withIsDynamicAction:NO];
}
-(void) doAnimation:(Animation*) panimation withIsDynamicAction:(BOOL) pisDynamicAction{
	if(isLoading)
		return;
	[self stopAnimation];
	curAnimation = panimation;
	[self debug:[NSString stringWithFormat:@"Animation %@ matches",panimation.label]];
	NSLog(@"animation duration: %d",[panimation getDuration]);
	if(panimation.soundId != nil)
	{
		[soundHandler playSound:panimation.soundId];
	}
	[animationHandler doAnimation:panimation];
	if(!pisDynamicAction)
	{
		[self resetIdle];
	}
	else {
		[panimation release];
	}
	
	
}
-(void) stopAnimation{
	[soundHandler stopSound];
	[animationHandler stopAnimation];
	curAnimation = nil;
}
-(void) setImage:(Image*) pimage{
	BOOL doRefresh = (curImage != pimage);
	curImage = pimage;
	if(doRefresh)
	{
		[self displayImage:curImage];
		
	}
}
-(void) setImageWithImageId:(NSString*) pimageId{
	Image *image = [curTheme.images objectForKey:pimageId];
	if(image != nil)
		[self setImage:image];
}

-(BOOL) useTheme:(NSString*) pthemeId
{
	if(curTheme != nil && [pthemeId isEqualToString:curTheme.uid])
	{
		NSLog(@"Already using theme %@",pthemeId);
		return YES;
	}
	isLoading = YES;
	[self stopAnimation];
	curTheme = [themes objectForKey:pthemeId];
	[curTheme load:self];
	curFeature = nil;
	[mainView useTheme:curTheme];
	[soundHandler loadSounds:curTheme.sounds];
	[self setImage:curTheme.defaultImage];
	[mainView resizeView];
	isLoading = NO;
	return YES;
}

-(void) debug:(NSObject*) po{
	NSLog(@"%@",po);
};

-(Animation*) createRandomAnimation{
	if(isLoading)
		return nil;
	int interval = 100+ (arc4random() % 400);
	NSInteger numberFrames = 2 + arc4random() % 8;
	NSString *uid = [NSString stringWithFormat:@"random%d",[NSDate timeIntervalSinceReferenceDate]];
	NSLog(@"Created animation %@",uid);
	Animation *result = [[[Animation alloc] initAnimation:uid withLabel:@"random" withInterval:(int)interval withRepeat:1 withVisible:NO withVibrate:NO withSoundId:nil] retain];
	Image *curAnimationImage = curImage;
	for(int i=0; i < numberFrames; i++)
	{
		Image *nextAnimationImage = [[self getRandomImage:curAnimationImage] retain];
		if(nextAnimationImage == nil)
			continue;
		CGFloat duration = 0.5f + (arc4random() %2);
		[result addImage:nextAnimationImage.uid withDuration:duration];
		curAnimationImage = nextAnimationImage;
	}
	return result;
}
-(Image*) getRandomImage:(Image*) pfromImage{
	NSArray *allAdjacentImages = [pfromImage getAllAdjacentImages];
	if([allAdjacentImages count] == 0)
		return nil;
	NSInteger toImageNumber = arc4random() % [allAdjacentImages count];
	Image *toImage = [allAdjacentImages objectAtIndex:toImageNumber];
	return toImage;
}
-(void) onIdle{
	[self resetIdle];
	NSLog(@"onIdle");
	if(curTheme != nil && curTheme.idleAnimation != nil)
	{
		if(![animationHandler isAnimationRunning])
			[self doAnimation:curTheme.idleAnimation.uid];
	}
}
-(BOOL) isIdleForSleepAnimation{
	if(lastActionTimestamp > 0)
	{
		return [NSDate timeIntervalSinceReferenceDate] - lastActionTimestamp > idleTimeout;
	}
	return NO;
}
-(BOOL) isIdleForRandomAnimation{
	if(lastActionTimestamp > 0)
	{
		return [NSDate timeIntervalSinceReferenceDate] - lastActionTimestamp > pingInterval;
	}
	return NO;
}
-(void) ping{
	if(isLoading)
		return;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	CGFloat idleTime = [NSDate timeIntervalSinceReferenceDate] - lastActionTimestamp;
	NSLog(@"ping: idle for %.2f seconds. Animation running? %s. duration=%.2f, animation images=%d, image=%@, repeat=%d", idleTime, [animationHandler isAnimationRunning]? "true" : "false",mainView.animationDuration, (mainView.animationImages == nil ? -1 :[mainView.animationImages count]), mainView.image, mainView.animationRepeatCount);
	
	if([self isIdleForSleepAnimation])
	{
		[self onIdle];
	}
	else {
		if([self isIdleForRandomAnimation] && ![animationHandler isAnimationRunning])
		{
			Animation *randomAnimation = [self createRandomAnimation];
			if(randomAnimation != nil)
				[self doAnimation:randomAnimation withIsDynamicAction:YES];
		}
		
	}
	[pool release];
}
-(void) reset{
	[self resetIdle];
	[self setImage:curTheme.defaultImage];
}
-(void) resetIdle{
	lastActionTimestamp = [NSDate timeIntervalSinceReferenceDate];
}
@end
