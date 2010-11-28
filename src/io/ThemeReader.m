//
//  ThemeReader.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ThemeReader.h"
#import "Theme.h"

@implementation ThemeReader
NSString * const COL_THEME_ID=@"Id";
NSString * const COL_THEME_NAME=@"Name";
@synthesize themes;
-(ThemeReader*) initThemeReader:(NSString *) pfilename{
	[super initNounoursReader:pfilename];
	themes = [[NSMutableDictionary alloc] init];
	[self load];
	return self;
}
-(void) readLine:(CSVReader *)pcsvReader{
	NSString *uid = [[pcsvReader getValue:COL_THEME_ID] retain];
	NSString *nameId = [[pcsvReader getValue:COL_THEME_NAME] retain];
	NSString *name = NSLocalizedString(nameId,@"");
	Theme *theme = [[Theme alloc] initTheme:uid withName:name];
	[themes setObject:theme forKey:uid];
}
@end
