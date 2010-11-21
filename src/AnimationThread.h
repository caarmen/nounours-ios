//
//  AnimationThread.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "data/Animation.h";
@class Nounours;

@interface AnimationThread : NSThread {
@private Nounours *nounours;
@private BOOL isRunning;
}
-(AnimationThread*) initAnimationThread:(Nounours*) pnounours withAnimation:(Animation*) panimation;
-(void) doAnimation:(Animation*) panimation;
-(void) stopAnimation;


@property(readonly) BOOL isRunning;
@end
