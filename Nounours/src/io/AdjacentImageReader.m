//
//  AdjacentImageReader.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/14/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import "AdjacentImageReader.h"
#import "Image.h"

NSString * const COL_ADJACENT_IMAGE_IMAGE_ID = @"ImageId";
NSString * const COL_ADJACENT_IMAGE_FEATURE_ID=@"FeatureId";
NSString * const COL_ADJACENT_IMAGE_ID=@"AdjacentImageId";

@implementation AdjacentImageReader
-(AdjacentImageReader*) initAdjacentImageReader:(NSMutableDictionary*) pimageMap andFilename:(NSString*) pfileName{
	self = [super initNounoursReader:pfileName];
	if(self)
	{
		imageMap = pimageMap;
		[self load];
	}
	return self;
}
-(void) readLine:(CSVReader*) reader{
	NSString* imageid = [reader getValue:COL_ADJACENT_IMAGE_IMAGE_ID];
	NSString* featureid = [reader getValue:COL_ADJACENT_IMAGE_FEATURE_ID];
	NSString* adjacentImageId = [reader getValue:COL_ADJACENT_IMAGE_ID];
	Image *image = [imageMap objectForKey:imageid];
	Image *adjacentImage = [imageMap objectForKey:adjacentImageId];
	[image addAdjacentImage:featureid andImage:adjacentImage];
}
@end
