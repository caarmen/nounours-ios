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

#import "Nounours.h"
#import "Util.h"
#import "data/Feature.h"
#import "io/FeatureReader.h"
#import "io/ImageReader.h"
#import "io/ImageFeatureReader.h"
#import "io/AdjacentImageReader.h"
#import "io/AnimationReader.h"
#import "io/FlingAnimationReader.h"
#import "data/Image.h"
#import "data/Animation.h"
#import "data/Sound.h"
#import "data/Theme.h"
#import "io/SoundReader.h"
#import "io/ThemeReader.h"
#import "Nounours-Swift.h"


@implementation Nounours

NSString * const PREF_THEME_ID = @"ThemeId";
NSString * const PREF_IMAGE_ID = @"ImageId";
NSString * const PREF_ENABLE_SOUND = @"PREF_ENABLE_SOUND";
NSString * const PREF_ENABLE_VIBRATE = @"PREF_ENABLE_VIBRATE";
NSString * const PREF_IDLE_TIMEOUT = @"PREF_IDLE_TIMEOUT";
@synthesize defaultImage;
@synthesize curTheme;
@synthesize curImage;
@synthesize themes;
@synthesize vibrateHandler;
@synthesize mainView;
@synthesize doVibrate;

-(Nounours*) initNounours:(MainView*) pmainView{
	self = [super init];
	if(self)
	{
		isLoading = YES;
		lastActionTimestamp = -1.0;
		curAnimation = nil;
		curImage = nil;
		doVibrate = YES;
		doSound = YES;
        NSString *themesFile = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"csv" inDirectory:@"res/themes"];
		NSLog(@"Reading themes..." );
		ThemeReader *themeReader = [[ThemeReader alloc] initThemeReader:themesFile];
		NSLog(@"Read themes.");
		themes = themeReader.themes;
		NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
		[self loadPreferences];
		
		NSArray *path = NSSearchPathForDirectoriesInDomains(
															NSLibraryDirectory, NSUserDomainMask, YES);
		NSString *folder = [path objectAtIndex:0];
		NSLog(@"Your NSUserDefaults are stored in this folder: %@/Preferences", folder);
		
		Theme *initialTheme = nil;
		Image *initialImage = nil;
		if(standardUserDefaults != nil)
		{
			NSString *savedThemeId = [standardUserDefaults objectForKey:PREF_THEME_ID];
			initialTheme = [themes objectForKey:savedThemeId];
		}
		else {
			NSLog(@"Could not retrieve user defaults");
		}
		
		if(initialTheme == nil) {
			NSArray *themeIds = [themes allKeys];
			NSArray *sortedThemeIds = [themeIds sortedArrayUsingSelector:@selector(compare:)];
			NSString *firstThemeId = [sortedThemeIds objectAtIndex:0];
			initialTheme = [themes valueForKey:firstThemeId];
		}
		[initialTheme load:self];
		
		if(idleTimeout < 1)
			idleTimeout = [Util getTimeIntervalProperty:initialTheme.properties withKey:@"idle.time" withDefaultValue:30.0f];
		pingInterval = [Util getTimeIntervalProperty:initialTheme.properties withKey:@"idle.ping.interval" withDefaultValue:5.0f];
		
		if(standardUserDefaults != nil)
		{
			NSString *initialImageId = [standardUserDefaults objectForKey:PREF_IMAGE_ID];
			if(initialTheme != nil && initialImageId != nil)
				initialImage = [[initialTheme images] objectForKey:initialImageId];
			
			NSLog(@"Saved image: %@",initialImage);
		}
		
		mainView = pmainView;
		[mainView setImageFromFilenameWithFilename:initialTheme.defaultImage.filename];
		soundHandler = [[SoundHandler alloc] initSoundHandler];
		animationHandler = [[AnimationHandler alloc] initAnimationHandler:self];
		vibrateHandler = [[VibrateHandler alloc] initVibrateHandler];
		orientationHandler = [[OrientationHandler alloc] initOrientationHandler:self];
		UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onFling:)];
		[mainView addGestureRecognizer:panRecognizer];
		[self performSelectorOnMainThread:@selector(useTheme:) withObject:initialTheme.uid waitUntilDone:YES];
		if(initialImage != nil)
			[self performSelectorOnMainThread:@selector(setImage:) withObject:initialImage waitUntilDone:NO];
		
		[self resetIdle];
		nounoursIdlePinger = [[NounoursIdlePinger alloc] initNounoursIdlePinger:self withPingInterval:pingInterval];
		[nounoursIdlePinger performSelectorInBackground:@selector(run:) withObject:nil];
		mainView.clipsToBounds = YES;
		mainView.contentMode = UIViewContentModeScaleAspectFit;
		
	}
	return self;
}

-(CGFloat) getDeviceWidth{
	CGRect rect = [mainView bounds] ;
	return rect.size.width;
}
-(CGFloat) getDeviceHeight{
	CGRect rect = [mainView bounds] ;
	return rect.size.height;
}

-(void) displayImage:(Image*)pimage{
	[mainView setImageFromFilenameWithFilename:[pimage filename]];
}

-(void) onPress:(CGFloat)px withY:(CGFloat)py{
	lastLocation.x = px;
	lastLocation.y = py;
	BOOL wasIdle = ([animationHandler isAnimationRunning] && curAnimation != nil
					&& curAnimation == curTheme.idleAnimation);
	[self stopAnimation];
	CGSize imageSize = mainView.image.size;
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
			if(doVibrate)
				[vibrateHandler doVibrate:nil];
		}
	}
	lastLocation.x=-1;
	lastLocation.y=-1;
	
}
-(void) onMove:(CGFloat)px withY:(CGFloat)py{
	BOOL doRefresh = YES;
	CGSize imageSize = mainView.image.size;
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
		CGSize size = mainView.image.size;
		CGPoint translatedPoint = [Util translate:lastLocation.x withDeviceY:lastLocation.y withDeviceWidth:[self getDeviceWidth] withDeviceHeight:[self getDeviceHeight] withImageWidth:size.width withImageHeight:size.height];
		[self debug:[NSString stringWithFormat:@"onFling:Pan started at (%f,%f). velocity:(%f,%f)",translatedPoint.x,translatedPoint.y, velocity.x, velocity.y]];
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
	[self setImage:curTheme.defaultImage];
	[self debug:[NSString stringWithFormat:@"Animation %@ matches",panimation.label]];
	if(panimation.soundId != nil && doSound)
	{
		[soundHandler playSound:panimation.soundId];
	}
	[animationHandler doAnimation:panimation];
	if(!pisDynamicAction)
	{
		[self resetIdle];
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
	[mainView useThemeWithTheme:curTheme];
	[soundHandler loadSounds:curTheme.sounds];
	[self setImage:curTheme.defaultImage];
	//[mainView resizeView];
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
	NSString *uid = [NSString stringWithFormat:@"random%f",[NSDate timeIntervalSinceReferenceDate]];
	Animation *result = [[Animation alloc] initAnimation:uid withLabel:@"random" withInterval:(int)interval withRepeat:1 withVisible:NO withVibrate:NO withSoundId:nil];
	Image *curAnimationImage = curImage;
	for(int i=0; i < numberFrames; i++)
	{
		Image *nextAnimationImage = [self getRandomImage:curAnimationImage];
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
	[NSOperationQueue.mainQueue addOperationWithBlock:^{[self pingImpl];}];
}

-(void) pingImpl {
	@autoreleasepool {
		CGFloat idleTime = [NSDate timeIntervalSinceReferenceDate] - lastActionTimestamp;
		NSLog(@"ping: idle for %.2f seconds. Animation running? %s. duration=%.2f, animation images=%lud, image=%@, repeat=%ld", idleTime, [animationHandler isAnimationRunning]? "true" : "false",mainView.animationDuration, (mainView.animationImages == nil ? -1 :[mainView.animationImages count]), mainView.image, (long)mainView.animationRepeatCount);

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
	}
}
-(void) reset{
	[self resetIdle];
	[self setImage:curTheme.defaultImage];
}
-(void) resetIdle{
	lastActionTimestamp = [NSDate timeIntervalSinceReferenceDate];
}

-(void) loadPreferences{
	NSLog(@"Loading preferences");
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *themeId = [standardUserDefaults stringForKey:PREF_THEME_ID];
	if(themeId == nil)
	{
		NSLog(@"First time running app, setting defaults");
		[standardUserDefaults setBool:YES forKey:PREF_ENABLE_SOUND];
		[standardUserDefaults setBool:YES forKey:PREF_ENABLE_VIBRATE];
		[standardUserDefaults setFloat:30.0f forKey:PREF_IDLE_TIMEOUT];
		[standardUserDefaults synchronize];
	}
	doVibrate = [standardUserDefaults boolForKey:PREF_ENABLE_VIBRATE];
	doSound = [standardUserDefaults boolForKey:PREF_ENABLE_SOUND];
	idleTimeout = [standardUserDefaults floatForKey:PREF_IDLE_TIMEOUT];
	NSLog(@"idle timeout: %.2f", idleTimeout);
	NSLog(@"sound: %s",doSound? "true" : "false");
	NSLog(@"vibrate: %s",doVibrate? "true" : "false");
}

-(void) savePreferences{
	NSLog(@"Saving preferences");
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	if(standardUserDefaults != nil)
	{
		if(curTheme != nil)
			[standardUserDefaults setObject:curTheme.uid forKey:PREF_THEME_ID];
		if(curImage != nil)
			[standardUserDefaults setObject:curImage.uid forKey:PREF_IMAGE_ID];
		[standardUserDefaults synchronize];
	}
	
}
- (void)onShown {
	[orientationHandler subscribeToAccelerometer];
}
- (void)onHidden {
	[orientationHandler unsubscribeToAccelerometer];
}
@end
