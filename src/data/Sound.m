//
//  Sound.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/23/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import "Sound.h"


@implementation Sound
-(Sound*) initSound:(NSString*) puid withFilename:(NSString*) pfilename{
	[super init];
	if(self)
	{
		uid = [puid retain];
		filename = [pfilename retain];
	}
	return self;
}

-(NSString*) description{
	return [NSString stringWithFormat:@"Sound id = %@, file=%@",uid,filename];
}
@synthesize uid;
@synthesize filename;
@end
