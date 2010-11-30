//
//  AnimationHandler.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "data/Animation.h"
#import "AnimationThread.h"

@class Nounours;

@interface AnimationHandler : NSObject {
@private Nounours *nounours;

}
-(AnimationHandler*) initAnimationHandler:(Nounours*) pnounours;

-(void) stopAnimation;
-(BOOL) isAnimationRunning;
-(void) doAnimation:(Animation*) panimation;
-(void) doAnimationImpl:(Animation*) panimation;

@end
