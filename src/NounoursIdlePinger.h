//
//  NounoursIdlePinger.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/30/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Nounours.h"

@interface NounoursIdlePinger : NSObject {
@private Nounours* nounours;
@private NSInteger pingInterval;
@private BOOL doPing;
}
-(NounoursIdlePinger*) initNounoursIdlePinger:(Nounours*) pnounours withPingInterval:(NSInteger) ppingInterval;
-(void) run:(id) sender;

@property(readwrite) NSInteger pingInterval;
@property(readwrite) BOOL doPing;

@end
