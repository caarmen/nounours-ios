//
//  FeatureReader.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NounoursReader.h"

@interface FeatureReader : NounoursReader {
	@private NSMutableArray* features;
}

-(FeatureReader*) initFeatureReader:(NSString*) pfileName;
-(void) readLine:(CSVReader*) preader;

@property(retain,readonly) NSArray* features;

@end
