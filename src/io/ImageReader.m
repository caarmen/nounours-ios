//
//  ImageReader.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageReader.h"
#import "Image.h"


@implementation ImageReader
NSString * const COL_IMAGE_ID=@"Id";
NSString * const COL_IMAGE_FILENAME = @"Filename";
NSString * const COL_IMAGE_ONRELEASE=@"OnRelease";
@synthesize images;

-(ImageReader*) initImageReader: (NSString*) pfileName {
	[super initNounoursReader:pfileName];
	if(self)
	{
		images = [[NSMutableDictionary alloc] init];
		[self load];
	}
	return self;
}
-(void) readLine:(CSVReader*) pcsvReader{
	NSString *uid = [pcsvReader getValue:COL_IMAGE_ID];
	NSString *filename = [pcsvReader getValue:COL_IMAGE_FILENAME];
	NSString *onReleaseImage = [pcsvReader getValue:COL_IMAGE_ONRELEASE];
	Image *image = [[Image alloc] initImage:uid andFilename:filename];
	if(onReleaseImage != nil && ![onReleaseImage length]==0)
	{
		[image setOnReleaseImageId:onReleaseImage];
	}
	[images setObject:image forKey:uid];
}

@end
