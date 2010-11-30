//
//  Nounours.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimationHandler.h"
#import "SoundHandler.h"
#import "VibrateHandler.h"
#import "ui/MainView.h";
#import "data/Image.h";
#import "data/Feature.h";
#import "data/FlingAnimation.h"
#import "data/Sound.h"
#import "data/Theme.h"
#import "OrientationHandler.h"

@class MainView;
@class OrientationHandler;

@interface Nounours : NSObject {
@private MainView* mainView;
@private Image *curImage;
@private Theme *curTheme;
@private Feature *curFeature;
@private NSMutableDictionary *themes;
@private AnimationHandler *animationHandler;
@private SoundHandler *soundHandler;
@private VibrateHandler *vibrateHandler;
@private OrientationHandler *orientationHandler;
@private CGPoint lastLocation;
}
-(Nounours*) initNounours:(MainView*) pmainView;
-(void) displayImage:(Image*)pimage;
-(void) onPress:(CGFloat)px withY:(CGFloat)py;
-(void) onRelease;
-(void) onMove:(CGFloat)px withY:(CGFloat)py;
-(void) onFling:(UIPanGestureRecognizer*) pgestureRecognizer;
-(void) onShake;
-(void) setImage:(Image*) pimage;
-(void) setImageWithImageId:(NSString*) pimageId;
-(void) debug:(NSObject*) po;
-(CGFloat) getDeviceWidth;
-(CGFloat) getDeviceHeight;
-(void) doAnimation:(NSString*) panimationId;
-(void) stopAnimation;
-(BOOL) useTheme:(NSString*) pthemeId;

@property(retain,readwrite) Image* defaultImage;
@property(retain,readonly) Theme *curTheme;
@property(retain,readonly) NSMutableDictionary *themes;
@property(retain,readonly) VibrateHandler* vibrateHandler;
@property(retain,readonly) MainView *mainView;

@end
