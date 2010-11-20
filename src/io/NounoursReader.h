//
//  NounoursReader.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSVReader.h"

@interface NounoursReader : NSObject {
	@private CSVReader* reader;
}

-(NounoursReader*) initNounoursReader:(NSString*) pfileName;
-(void) load;
-(void) readLine:(CSVReader*) pcsvReader;

@end
