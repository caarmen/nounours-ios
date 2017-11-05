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

#import "ThemeReader.h"
#import "Theme.h"

@implementation ThemeReader
NSString * const COL_THEME_ID=@"Id";
NSString * const COL_THEME_NAME=@"Name";
@synthesize themes;
-(ThemeReader*) initThemeReader:(NSString *) pfilename{
	self = [super initNounoursReader:pfilename];
	themes = [[NSMutableDictionary alloc] init];
	[self load];
	return self;
}
-(void) readLine:(CSVReader *)pcsvReader{
    NSString *uid = [pcsvReader getValue:COL_THEME_ID];
    NSString *nameId = [pcsvReader getValue:COL_THEME_NAME];
	NSString *name = NSLocalizedString(nameId,@"");
	Theme *theme = [[Theme alloc] initTheme:uid withName:name];
	[themes setObject:theme forKey:uid];
}
@end
