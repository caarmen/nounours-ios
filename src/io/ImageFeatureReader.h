//
//  ImageFeatureReader.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NounoursReader.h"

@interface ImageFeatureReader : NounoursReader {
@private NSMutableDictionary* imageMap;
@private NSMutableDictionary* featureMap;
}
-(ImageFeatureReader*) initImageFeatureReader:(NSMutableDictionary*) pimageMap andFeatures:(NSArray*) pfeatures andFilename:(NSString*) pfileName;

@end
