//
//  Theme.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Theme.h"
#import "PropertiesReader.h"

@implementation Theme
@synthesize height;
@synthesize width;
@synthesize uid;
@synthesize name;
//@synthesize location
@synthesize isLoaded;
-(Theme*) initTheme:(NSString*) puid withName:(NSString*) pname /*withLocation(NSString*) plocation*/{
	[super init];
	uid = puid;
	name = pname;
	//location = plocation;
	NSString *propertiesPath = [[NSBundle mainBundle] pathForResource:@"nounours" ofType:@"properties" inDirectory:[NSString stringWithFormat:@"themes/%@",uid]];	
	PropertiesReader *propReader = [[PropertiesReader alloc] initPropertiesReader:propertiesPath];
	properties = propReader.data;
	
	return self;
	
}
-(NSString*) description{
	return [NSString stringWithFormat:@"%@,%@,%@",uid,name/*,location*/];
}
-(NSString*) getPath:(NSString*) pfilename{
	NSString *path = [[NSBundle mainBundle] pathForResource:pfilename ofType:@"csv" inDirectory:uid];	
	return path;
}
@end
