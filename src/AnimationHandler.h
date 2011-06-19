//
//  AnimationHandler.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/21/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
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
