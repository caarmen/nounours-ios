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
