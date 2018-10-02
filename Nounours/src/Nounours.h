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

#ifndef NOUNOURS_H
#define NOUNOURS_H
#import <Foundation/Foundation.h>
#import "AnimationHandler.h"
#import "SoundHandler.h"
#import "VibrateHandler.h"
#import "data/Image.h"
#import "data/Feature.h"
#import "data/FlingAnimation.h"
#import "data/Sound.h"
#import "OrientationHandler.h"
#import "NounoursIdlePinger.h"

@class MainView;
@class OrientationHandler;
@class NounoursIdlePinger;
@class Theme;
@interface Nounours : NSObject {
@private MainView* mainView;
@private Image *curImage;
@private Theme *curTheme;
@private Animation *curAnimation;
@private Feature *curFeature;
@private NSMutableDictionary *themes;
@private AnimationHandler *animationHandler;
@private SoundHandler *soundHandler;
@private VibrateHandler *vibrateHandler;
@private OrientationHandler *orientationHandler;
@private CGPoint lastLocation;
@private BOOL isLoading;
@private CGFloat idleTimeout;
@private CGFloat pingInterval;
@private NSTimeInterval lastActionTimestamp;
@private NounoursIdlePinger *nounoursIdlePinger;
@private BOOL doVibrate;
@private BOOL doSound;

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
-(void) doAnimation:(Animation*) panimation withIsDynamicAction:(BOOL) pisDynamicAction;
-(void) doAnimation:(NSString*) panimationId;
-(void) stopAnimation;
-(BOOL) useTheme:(NSString*) pthemeId;

-(Image*) getRandomImage:(Image*) pfromImage;
-(Animation*) createRandomAnimation;
-(void) onIdle;
-(void) onShown;
-(void) onHidden;
-(BOOL) isIdleForSleepAnimation;
-(BOOL) isIdleForRandomAnimation;
-(void) ping;
-(void) resetIdle;
-(void) reset;
-(void) loadPreferences;
-(void) savePreferences;

@property(retain,readwrite) Image* defaultImage;
@property(retain,readonly) Theme *curTheme;
@property(retain,readonly) Image *curImage;
@property(retain,readonly) NSMutableDictionary *themes;
@property(retain,readonly) VibrateHandler* vibrateHandler;
@property(retain,readonly) MainView *mainView;
@property(readonly) BOOL doVibrate;

@end
#endif
