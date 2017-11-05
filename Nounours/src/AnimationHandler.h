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
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "data/Animation.h"

@class Nounours;

@interface AnimationHandler : NSObject {
@private Nounours *nounours;
@private NSTimeInterval timeLastAnimationLaunched;
@private CGFloat curAnimationDuration;

}
-(AnimationHandler*) initAnimationHandler:(Nounours*) pnounours;

-(void) stopAnimation;
-(BOOL) isAnimationRunning;
-(void) doAnimation:(Animation*) panimation;
-(void) doAnimationImpl:(Animation*) panimation;


@end
