//
//  FeatureReader.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import "FeatureReader.h"
#import "Feature.h"


@implementation FeatureReader
NSString * const COL_FEATURE_ID=@"Id";
NSString * const COL_FEATURE_DESCRIPTION = @"Description";
@synthesize features;

-(FeatureReader*) initFeatureReader:(NSString*) pfileName{
	[super initNounoursReader:pfileName];
	if(self)
	{
		//NSMutableArray *array = [[NSMutableArray alloc] init];
		features = [[NSMutableArray alloc] init];
		//[array release];
		[self load];
	}
	return self;
}
-(void) readLine:(CSVReader*) preader{
	NSString *uid = [preader getValue:COL_FEATURE_ID];
	NSString *description = [preader getValue:COL_FEATURE_DESCRIPTION];
	Feature *feature = [[Feature alloc] initFeature:uid andName:description];
	[features addObject:feature];
}
@end
