//
//  NounoursIdlePinger.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NounoursIdlePinger.h"


@implementation NounoursIdlePinger
@synthesize pingInterval;
@synthesize doPing;

-(NounoursIdlePinger*) initNounoursIdlePinger:(Nounours*) pnounours withPingInterval:(NSInteger) ppingInterval{
	[super init];
	nounours = pnounours;
	pingInterval = ppingInterval;
	doPing = YES;
	return self;
}

-(void) run:(id) sender{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	while(YES)
	{
		if(doPing)
		{
			[nounours performSelectorInBackground:@selector(ping) withObject:nil];
		}
		[NSThread sleepForTimeInterval:pingInterval]; 
	}
	[pool release];
}
@end
