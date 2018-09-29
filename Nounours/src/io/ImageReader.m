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

#import "ImageReader.h"
#import "Image.h"


@implementation ImageReader
NSString * const COL_IMAGE_ID=@"Id";
NSString * const COL_IMAGE_FILENAME = @"Filename";
NSString * const COL_IMAGE_ONRELEASE=@"OnRelease";
@synthesize images;

-(ImageReader*) initImageReader: (NSString*) pfileName {
	self = [super initNounoursReader:pfileName];
	if(self)
	{
		imagePath = [NSString stringWithFormat:@"%@/images",[[pfileName stringByDeletingLastPathComponent] stringByDeletingLastPathComponent]];
		images = [[NSMutableDictionary alloc] init];
		[self load];
	}
	return self;
}
-(void) readLine:(CSVReader*) pcsvReader{
	NSString *uid = [pcsvReader getValue:COL_IMAGE_ID];
	NSString *filename = [pcsvReader getValue:COL_IMAGE_FILENAME];
	NSString *path = [NSString stringWithFormat:@"%@/%@",imagePath,filename];
	NSString *onReleaseImage = [pcsvReader getValue:COL_IMAGE_ONRELEASE];
	Image *image = [[Image alloc] initImage:uid andFilename:path];
	if(onReleaseImage != nil && [onReleaseImage length]!=0)
	{
		[image setOnReleaseImageId:onReleaseImage];
	}
	[images setObject:image forKey:uid];
}

@end
