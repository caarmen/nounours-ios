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
