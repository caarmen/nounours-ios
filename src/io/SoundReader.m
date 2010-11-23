//
//  SoundReader.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SoundReader.h"
#import "../data/Sound.h"

NSString * const COL_SOUND_ID = @"Id";
NSString * const COL_SOUND_FILENAME = @"Filename";
@implementation SoundReader
@synthesize sounds;
-(SoundReader*) initSoundReader:(NSString*)pfilename{
	[super initNounoursReader:pfilename];
	sounds = [[NSMutableDictionary alloc] init];
	[self load];
	return self;
}
-(void) readLine:(CSVReader*) pcsvReader{
	NSString *uid = [pcsvReader getValue:COL_SOUND_ID];
	NSString *filename = [pcsvReader getValue:COL_SOUND_FILENAME];
	Sound * sound = [[Sound alloc] initSound:uid withFilename:filename];
	[sounds setObject:sound forKey:uid];
	
}
@end
