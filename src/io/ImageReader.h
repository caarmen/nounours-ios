//
//  ImageReader.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NounoursReader.h"

@interface ImageReader : NounoursReader {
@private NSMutableDictionary *images;
@private NSString *imagePath;
}
-(ImageReader*) initImageReader: (NSString*) pfileName;
@property(retain,readonly) NSMutableDictionary* images;
@end
