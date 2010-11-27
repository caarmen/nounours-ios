//
//  VibrateHandler.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "VibrateHandler.h"


@implementation VibrateHandler
-(VibrateHandler*) initVibrateHandler{
	[super init];
	return self;
}
-(void) doVibrate:(NSDictionary*) pdurationAndInterval{
	
	NSNumber *numBursts = [NSNumber numberWithInt:1];
	NSNumber *interval = [NSNumber numberWithFloat:0];
	
	if(pdurationAndInterval != nil)
	{
		numBursts = [pdurationAndInterval objectForKey:@"NUMBURSTS"];
		interval = [pdurationAndInterval objectForKey:@"INTERVAL"];
	}
	
	for(int i=0; i < [numBursts intValue]; i++)
	{
		AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
		NSLog(@"Vibrate");
		[NSThread  sleepForTimeInterval:[interval floatValue]];
	}
}
-(void) doVibrate:(long) pduration withInterval:(CGFloat) pinterval{
	CGFloat duration = ((CGFloat)pduration) / 1000;
	CGFloat interval = pinterval;
	if(interval <1.0)
		interval = 1.0;
	NSNumber *numInterval = [NSNumber numberWithFloat:interval];
	NSNumber *numBursts = [NSNumber numberWithInt:(duration / interval)];
	NSDictionary *durationAndInterval = [[NSDictionary alloc] initWithObjectsAndKeys:numInterval,@"INTERVAL",numBursts,@"NUMBURSTS",nil];
	[self performSelectorInBackground:@selector(doVibrate:) withObject:durationAndInterval]; 
		
	
}
@end
