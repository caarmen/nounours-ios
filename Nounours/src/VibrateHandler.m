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

#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
#import "VibrateHandler.h"


@implementation VibrateHandler
-(VibrateHandler*) initVibrateHandler{
	self = [super init];
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
