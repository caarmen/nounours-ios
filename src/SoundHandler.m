//
//  SoundHandler.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/23/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "SoundHandler.h"
#import "data/Sound.h"

@implementation SoundHandler

-(SoundHandler*) initSoundHandler{
	[super init];
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
