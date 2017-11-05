//
//  PropertiesReader.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/25/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import "PropertiesReader.h"


@implementation PropertiesReader
@synthesize data;
NSString * const PROPERTIES_LINE_SEPARATOR = @"\r\n";
-(PropertiesReader*) initPropertiesReader:(NSString*) pfilename{
	self = [super init];
	data = [[NSMutableDictionary alloc] init];
	//NSString *path = [[NSBundle mainBundle] pathForResource:pfilename ofType:@"properties"];
	NSString *wholeContentsStr = [NSString stringWithContentsOfFile:pfilename encoding:NSISOLatin1StringEncoding error:NULL];
	NSArray *wholeContents = [wholeContentsStr componentsSeparatedByString:PROPERTIES_LINE_SEPARATOR];
	for (NSString *line in wholeContents)
	{
		if([line hasPrefix:@"#"])
			continue;
		NSRange equal = [line rangeOfString:@"="];
		if(equal.length == 0)
			continue;
		NSString *key = [line substringToIndex:equal.location];
		NSString *value = [line substringFromIndex:(equal.location+1)];
		[data setObject:value forKey:key];
		
	}

	return self;
	
	
}
@end
