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
#import "io/SoundReader.h"

@implementation Nounours
@synthesize defaultImage;


-(Nounours*) initNounours:(MainView*) pmainView{
	[super init];
	if(self)
	{
		images = [[NSMutableDictionary alloc] init];
		mainView = pmainView;
		NSString *featureFile = @"feature";
		FeatureReader* featureReader = [[FeatureReader alloc] initFeatureReader:featureFile];
		NSArray* features = [featureReader features];
		for (Feature* feature in features)
		{
			NSLog(@"%@",feature);
		}
		ImageReader* imageReader = [[ImageReader alloc] initImageReader:@"image"];
		NSDictionary* readImages = [imageReader images];
		ImageFeatureReader* imageFeatureReader = [[ImageFeatureReader alloc] initImageFeatureReader:(NSMutableDictionary*)readImages andFeatures:features andFilename:@"imagefeatureassoc"];
		
		AdjacentImageReader* adjacentImageReader = [[AdjacentImageReader alloc] initAdjacentImageReader:(NSMutableDictionary*)readImages andFilename:@"adjacentimage"];
		
		[mainView setImageFromFilename:@"defaultimg_sm.jpg"];
		AnimationReader *animationReader = [[AnimationReader alloc]initAnimationReader:@"animation"];
		animations = [animationReader animations];
		SoundReader *soundReader = [[SoundReader alloc] initSoundReader:@"sound"];
		soundHandler = [[SoundHandler alloc] initSoundHandler:soundReader.sounds];
		animationHandler = [[AnimationHandler alloc] initAnimationHandler:self];
		FlingAnimationReader* flingAnimationReader = [[FlingAnimationReader alloc] initFlingAnimationReader:@"flinganimation"];
		flingAnimations = [flingAnimationReader flingAnimations];
		UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onFling:)];
		[mainView addGestureRecognizer:panRecognizer];
		[panRecognizer release];
		
		for (Image* image in [readImages allValues])
		{
			
			[images setValue:image forKey:image.uid];
			if([image.uid isEqualToString:@"Default"])
			{
				self.defaultImage = image;
			}
			
			NSLog(@"%@",image);
		}
		[self setImage:defaultImage];
		[self resizeView];
		[imageFeatureReader release];
		[adjacentImageReader release];

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
	[animationHandler stopAnimation];
	CGSize imageSize = [mainView getImageSize];
	CGPoint translatedPoint = [Util translate:px withDeviceY:py withDeviceWidth:[self getDeviceWidth] withDeviceHeight:[self getDeviceHeight] withImageWidth:imageSize.width withImageHeight:imageSize.height];
	//[self debug:[NSString stringWithFormat:@"onPress %f,%f=>%f,%f",px,py,translatedPoint.x,translatedPoint.y]];
	
	if(curImage == nil)
		return;
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
-(void) onRelease{
	curFeature = nil;
	[self debug:@"onRelease"];
	if(curImage != nil)
	{
		NSString *nextImageId = curImage.onReleaseImageId;
		if(nextImageId != nil)
		{
			Image *nextImage = [images objectForKey:nextImageId];
			[self setImage:nextImage];
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
		else {
			curImage = defaultImage;
		}
		
	}
	if(doRefresh)
		[self displayImage:curImage];
}

-(void) onFling:(UIPanGestureRecognizer*) pgestureRecognizer{
	CGPoint location = [pgestureRecognizer locationInView:mainView];
	CGPoint velocity = [pgestureRecognizer velocityInView:mainView];
	if(isnan(location.x))
	{
		CGPoint translatedPoint = [Util translate:lastLocation.x withDeviceY:lastLocation.y withDeviceWidth:[self getDeviceWidth] withDeviceHeight:[self getDeviceHeight] withImageWidth:[mainView getImageSize].width withImageHeight:[mainView getImageSize].height]; 
		[self debug:[NSString stringWithFormat:@"onFling:Pan started at (%f,%f). %velocity:(%f,%f)",translatedPoint.x,translatedPoint.y, velocity.x, velocity.y]];
		for(FlingAnimation* flingAnimation in flingAnimations )
		{
			[self debug:[NSString stringWithFormat:@"testing %@",flingAnimation.animationId]];
			if(![Util isFaster:velocity.x withV2:flingAnimation.minVelX])
			{
				NSLog(@"X: %f not faster than %f",velocity.x,flingAnimation.minVelX);
				continue;
			}
			if(![Util isFaster:velocity.y withV2:flingAnimation.minVelY]){
				NSLog(@"Y: %f not faster than %f",velocity.y,flingAnimation.minVelY);
				continue;
			}
			if(![Util pointIsInSquare:translatedPoint.x withPointY:translatedPoint.y withSquareX:flingAnimation.x withSquareY:flingAnimation.y withSquareWidth:flingAnimation.width withSquareHeight:flingAnimation.height])
			{
				NSLog(@"fast enough, not in square");
				continue;
			}
			Animation* animation = [animations objectForKey:flingAnimation.animationId];
			[self doAnimation:animation.uid];
			
		}
		if(!animationHandler.isAnimationRunning)
			 [self onRelease];
											
	}
	else {
		[self onMove:location.x withY:location.y];
	}

}
-(void) doAnimation:(NSString *)panimationId{
	Animation* animation = [animations objectForKey:panimationId];
	[self debug:[NSString stringWithFormat:@"Animation %@ matches",animation.label]];
	[animationHandler doAnimation:animation];
	[soundHandler stopSound];
	if(animation.soundId != nil)
	{
		[soundHandler playSound:animation.soundId];
	}
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
	Image *image = [images objectForKey:pimageId];
	if(image != nil)
		[self setImage:image];
}
-(void) resizeView{
	CGSize imageSize = [mainView getImageSize];
	CGRect deviceSize = [[UIScreen mainScreen ]bounds] ;
	CGFloat widthRatio = deviceSize.size.width / imageSize.width;
	CGFloat heightRatio = deviceSize.size.height / imageSize.height;
	CGFloat ratioToUse = widthRatio > heightRatio ? heightRatio : widthRatio;
	CGFloat width = ratioToUse*imageSize.width;
	CGFloat height = ratioToUse*imageSize.height;
	CGFloat offsetX = 0;
	CGFloat offsetY = 0;
	if(heightRatio > widthRatio) {file://localhost/Users/calvarez/dev/projects/ios/Nounours/res/images/rotate430_sm.jpg
		offsetY = (CGFloat) ((deviceSize.size.height - ratioToUse*imageSize.height)/2);
	}
	else {
		offsetX = (CGFloat) ((deviceSize.size.width - ratioToUse * imageSize.width) / 2);
	}
	
	CGRect newSize = CGRectMake(offsetX, offsetY, width, height);
	mainView.frame = newSize;
}
-(void) debug:(NSObject*) po{
	NSLog(@"%@",po);
};

@end
