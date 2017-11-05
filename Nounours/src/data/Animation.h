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


@interface Animation : NSObject {
@private NSMutableArray* images;
@private NSString* uid;
@private NSString* label;
@private int interval;
@private int repeat;
@private BOOL visible;
@private BOOL vibrate;
@private NSString* soundId;
}

-(Animation*) initAnimation:(NSString *)puid withLabel:(NSString*) plabel withInterval:(int) pinterval withRepeat:(int) prepeat withVisible:(BOOL) pvisible
withVibrate:(BOOL) pvibrate withSoundId:(NSString*) psoundId;

-(void) addImage:(NSString*)pimageId withDuration:(float)pduration;
-(long) getDuration;
-(Animation*) clone;

@property(retain,readonly) NSMutableArray* images;
@property(retain,readonly) NSString* uid;
@property(retain,readonly) NSString* label;
@property(readonly) int interval;
@property(readonly) int repeat;
@property(readonly) BOOL visible;
@property(readonly) BOOL vibrate;
@property(readonly) NSString* soundId;
@end
