//
//  SoundReader.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NounoursReader.h"

@interface SoundReader : NounoursReader {
@private NSMutableDictionary* sounds;
@private NSString *soundPath;	
}
-(SoundReader*) initSoundReader:(NSString*)pfilename;
@property(retain,readonly) NSMutableDictionary* sounds;
@end
