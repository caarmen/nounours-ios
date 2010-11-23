//
//  SoundHandler.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "SoundHandler.h"
#import "data/Sound.h"

@implementation SoundHandler

-(SoundHandler*) initSoundHandler:(NSMutableDictionary*) psounds{
	[super init];
	sounds = psounds;
	audioPlayers = [[NSMutableDictionary alloc] init];
	for (Sound *sound in [psounds allValues])
	{
		AVAudioPlayer *audioPlayer = [audioPlayers objectForKey:sound.uid];
		if(audioPlayer == nil)
		{
			NSString *urlString = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],sound.filename];
			NSURL *url = [NSURL fileURLWithPath:urlString];
			NSError *error;
			
			audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
			if(audioPlayer == nil)
				NSLog(@"%@",[error description]);
			else
				[audioPlayers setObject:audioPlayer forKey:sound.uid];
		}
		
	}
	return self;
}
-(void) playSound:(NSString*) psoundId{
	Sound *sound = [sounds objectForKey:psoundId];
	AVAudioPlayer *audioPlayer = [audioPlayers objectForKey:sound.uid];
	if(audioPlayer != nil)
		[audioPlayer play];
}

-(void) stopSound{
	for(AVAudioPlayer* audioPlayer in [audioPlayers allValues])
	{
		[audioPlayer stop];
	}
}

@end
