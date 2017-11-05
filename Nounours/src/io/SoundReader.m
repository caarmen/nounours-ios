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
