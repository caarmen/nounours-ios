//
//  FlingAnimationReader.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NounoursReader.h"

@interface FlingAnimationReader : NounoursReader {
@private NSMutableArray* flingAnimations;
}
-(FlingAnimationReader*) initFlingAnimationReader:(NSString*)pfilename;
@property(retain,readonly) NSMutableArray* flingAnimations;
@end
