//
//  SoundReader.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/23/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import "SoundReader.h"
#import "../data/Sound.h"

NSString * const COL_SOUND_ID = @"Id";
NSString * const COL_SOUND_FILENAME = @"Filename";
@implementation SoundReader
@synthesize sounds;
-(SoundReader*) initSoundReader:(NSString*)pfilename{
	self = [super initNounoursReader:pfilename];
	soundPath = [NSString stringWithFormat:@"%@/sounds",[[pfilename stringByDeletingLastPathComponent] stringByDeletingLastPathComponent]];
	sounds = [[NSMutableDictionary alloc] init];
	[self load];
	return self;
}
-(void) readLine:(CSVReader*) pcsvReader{
	NSString *uid = [pcsvReader getValue:COL_SOUND_ID];
	NSString *filename = [pcsvReader getValue:COL_SOUND_FILENAME];
	NSString *path = [NSString stringWithFormat:@"%@/%@",soundPath,filename];
	NSData *soundContents = [[NSFileManager defaultManager] contentsAtPath:path];
	if(soundContents == nil || [soundContents length] == 0)
	{
		NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
		path = [NSString stringWithFormat:@"%@/res/themes/common/sounds/%@",bundlePath,filename];
	}

	Sound * sound = [[Sound alloc] initSound:uid withFilename:path];
	[sounds setObject:sound forKey:uid];
	
}
@end
