//
//  PropertiesReader.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PropertiesReader.h"


@implementation PropertiesReader
@synthesize data;
NSString * const PROPERTIES_LINE_SEPARATOR = @"\r\n";
-(PropertiesReader*) initPropertiesReader:(NSString*) pfilename{
	[super init];
	data = [[NSMutableDictionary alloc] init];
	//NSString *path = [[NSBundle mainBundle] pathForResource:pfilename ofType:@"properties"];
	NSString *wholeContentsStr = [NSString stringWithContentsOfFile:pfilename encoding:NSISOLatin1StringEncoding error:NULL];
	NSArray *wholeContents = [wholeContentsStr componentsSeparatedByString:PROPERTIES_LINE_SEPARATOR];
	for (NSString *line in wholeContents)
	{
		if([line hasPrefix:@"#"])
			continue;
		NSRange equal = [line rangeOfString:@"="];
		NSString *key = [[line substringToIndex:equal.location] retain];
		NSString *value = [[line substringFromIndex:(equal.location+1)] retain];
		[data setObject:value forKey:key];
		
	}
	for(NSString *key in [data allKeys])
	{
		NSString *value = [data objectForKey:key];
		NSLog(@"%@=%@",key,value);
	}
	return self;
	
	
}
@end
