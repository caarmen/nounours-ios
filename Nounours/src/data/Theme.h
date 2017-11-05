//
//  Theme.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/25/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animation.h"
#import "Sound.h"
#import "FlingAnimation.h"
#import "Image.h"
#import "Nounours.h"
#import "OrientationImage.h"

@interface Theme : NSObject {
@private NSMutableDictionary *images;
@private NSMutableDictionary *animations;
@private NSMutableDictionary *sounds;
@private NSArray *flingAnimations;
@private NSMutableSet *orientationImages;
@private Animation *shakeAnimation;
@private Animation *resumeAnimation;
@private Animation *idleAnimation;
@private Animation *endIdleAnimation;
@private NSMutableDictionary *properties;
@private Image *helpImage;
@private Image *defaultImage;
@private NSString *uid;
@private NSString *name;
//@private NSURL *location;
@private CGFloat height;
@private CGFloat width;
	
@private BOOL isLoaded;
}

-(Theme*) initTheme:(NSString*) puid withName:(NSString*)pname/*withLocation:(NSString*) plocation*/;
-(NSString*) getPath:(NSString*) pfilename;
-(void) load:(Nounours*) pnounours;
@property (readonly) CGFloat height;
@property (readonly) CGFloat width;
@property (retain,readonly) NSString *uid;
@property (retain,readonly) NSString *name;
//@property (retain,readonly) NSURL *location;
@property (readonly) BOOL isLoaded;
@property (retain,readonly) NSMutableDictionary *images;
@property (retain,readonly) NSMutableDictionary *animations;
@property (retain,readonly) NSMutableDictionary *sounds;
@property (retain, readonly) NSMutableSet *orientationImages;
@property (retain, readonly) NSArray *flingAnimations;
@property (retain, readonly) Animation* shakeAnimation;
@property (retain, readonly) Animation* resumeAnimation;
@property (retain, readonly) Animation* idleAnimation;
@property (retain, readonly) Animation* endIdleAnimation;
@property (retain, readonly) Image *helpImage;
@property (retain, readonly) Image *defaultImage;
@property (retain, readonly) NSMutableDictionary *properties;
@end
