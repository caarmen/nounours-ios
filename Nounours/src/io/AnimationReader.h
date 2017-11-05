//
//  AnimationReader.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/20/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NounoursReader.h"

@interface AnimationReader : NounoursReader {
@private NSMutableDictionary* animations;
	
}
-(AnimationReader*) initAnimationReader:(NSString*) pfileName;
@property(retain,readonly) NSMutableDictionary* animations;
@end
