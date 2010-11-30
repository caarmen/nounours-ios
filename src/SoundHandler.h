//
//  SoundHandler.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SoundHandler : NSObject {
@private NSMutableDictionary* sounds;
@private NSMutableDictionary* audioPlayers;
}
-(SoundHandler*) initSoundHandler;
-(void) loadSounds:(NSMutableDictionary*) psounds;
-(void) playSound:(NSString*) psoundId;
-(void) stopSound;
@end
