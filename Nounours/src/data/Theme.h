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
