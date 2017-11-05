//
//  NounoursReader.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import "NounoursReader.h"


@implementation NounoursReader
-(NounoursReader*) initNounoursReader:(NSString*) pfileName{
	self = [super init];
	if(self != nil)
	{
		reader = [[CSVReader alloc]initCSVReader:pfileName];
	}
	return self;
}
-(void) load{
	while ([reader next]) {
		[self readLine: reader];
	}
	[reader close];
}
-(void) readLine:(CSVReader*) pcsvReader{
	// ABSTRACT
}

@end
