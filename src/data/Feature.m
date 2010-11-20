//
//  Feature.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Feature.h"


@implementation Feature

@synthesize uid;
@synthesize featureName;

-(Feature*) initFeature : (NSString*) puid andName: (NSString*) pname{
	self = [super init];
	if (self) {
		uid = [puid retain];
		featureName = [pname retain];
	}
	return self;
}
- (NSString *)description{
	return [NSString stringWithFormat:@"%@: %@,%@",
		   NSStringFromClass(self.class),uid,featureName];
}
@end
