//
//  NounoursIdlePinger.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/30/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import "NounoursIdlePinger.h"


@implementation NounoursIdlePinger
@synthesize pingInterval;
@synthesize doPing;

-(NounoursIdlePinger*) initNounoursIdlePinger:(Nounours*) pnounours withPingInterval:(NSInteger) ppingInterval{
	self = [super init];
	nounours = pnounours;
	pingInterval = ppingInterval;
	doPing = YES;
	return self;
}

-(void) run:(id) sender{
    @autoreleasepool {
    while(YES)
        {
            if(doPing)
            {
                [nounours performSelectorInBackground:@selector(ping) withObject:nil];
            }
            [NSThread sleepForTimeInterval:pingInterval];
        }
    }
}
@end
