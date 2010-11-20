//
//  AdjacentImageReader.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NounoursReader.h"

@interface AdjacentImageReader : NounoursReader {
@private NSMutableDictionary* imageMap;
}
-(AdjacentImageReader*) initAdjacentImageReader:(NSMutableDictionary*) pimageMap andFilename:(NSString*) pfileName;
@end
