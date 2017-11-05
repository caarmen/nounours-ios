//
// Copyright (c) 2010 - 2011 Carmen Alvarez
//
// This file is part of Nounours for iOS.
//
// Nounours for iOS is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Nounours for iOS is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Nounours for iOS.  If not, see <http://www.gnu.org/licenses/>.
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
