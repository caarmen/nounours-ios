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

#import <AVFoundation/AVFoundation.h>
#import "SoundHandler.h"
#import "data/Sound.h"

@implementation SoundHandler

-(SoundHandler*) initSoundHandler{
	self = [super init];
	audioPlayers = [[NSMutableDictionary alloc] init];
	return self;
}
-(void) loadSounds:(NSMutableDictionary*) psounds{
	sounds = psounds;	
	for (Sound *sound in [psounds allValues])
	{
		AVAudioPlayer *audioPlayer = [audioPlayers objectForKey:sound.filename];
		if(audioPlayer == nil)
		{
			NSURL *url = [NSURL fileURLWithPath:sound.filename];
			NSError *error;
			
			audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
			if(audioPlayer == nil)
				NSLog(@"Could not load %@:%@",sound,[error description]);
			else
				[audioPlayers setObject:audioPlayer forKey:sound.filename];
		}
		
	}
}
-(void) playSound:(NSString*) psoundId{
	Sound *sound = [sounds objectForKey:psoundId];
	AVAudioPlayer *audioPlayer = [audioPlayers objectForKey:sound.filename];
	if(audioPlayer != nil)
		[audioPlayer play];
}

-(void) stopSound{
	for(AVAudioPlayer* audioPlayer in [audioPlayers allValues])
	{
		[audioPlayer stop];
		audioPlayer.currentTime = 0;
	}
}

@end
