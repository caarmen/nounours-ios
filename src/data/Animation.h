//
//  Animation.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/20/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
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
