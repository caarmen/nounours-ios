//
//  FlingAnimation.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/20/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>


@interface FlingAnimation : NSObject {
@private NSString *uid;
@private CGFloat x;
@private CGFloat y;
@private CGFloat width;
@private CGFloat height;
@private CGFloat minVelX;
@private CGFloat minVelY;
@private NSString* animationId;
@private BOOL variableSpeed;
}

-(FlingAnimation*) initFlingAnimation:(NSString*) puid withX:(CGFloat) px withY:(CGFloat) py withWidth:(CGFloat) pwidth withHeight:(CGFloat) pheight withMinVelX:(CGFloat)pminVelX withMinVelY:(CGFloat)pminVelY withAnimationId:(NSString*) panimationId withVariableSpeed:(BOOL) pvariableSpeed;
@property(retain,readonly) NSString *uid;
@property(readonly) CGFloat x;
@property(readonly) CGFloat y;
@property(readonly) CGFloat width;
@property(readonly) CGFloat height;
@property(readonly) CGFloat minVelX;
@property(readonly) CGFloat minVelY;
@property(retain,readonly) NSString* animationId;
@property(readonly) BOOL variableSpeed; 
@end
