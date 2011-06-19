//
//  ImageFeatureReader.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/14/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import "ImageFeatureReader.h"
#import "Feature.h"
#import "Image.h"
NSString * const COL_IMAGE_FEATURE_IMAGE_ID = @"ImageId";
NSString * const COL_IMAGE_FEATURE_FEATURE_ID=@"FeatureId";
NSString * const COL_IMAGE_FEATURE_X = @"X";
NSString * const COL_IMAGE_FEATURE_Y=@"Y";
@implementation ImageFeatureReader
-(ImageFeatureReader*) initImageFeatureReader:(NSMutableDictionary*) pimageMap andFeatures:(NSArray*) pfeatures
								  andFilename:(NSString*) pfileName{
	[super initNounoursReader:pfileName];
	if(self)
	{
		imageMap = pimageMap;
		featureMap = [[NSMutableDictionary alloc] init];
		for(Feature* feature in pfeatures)
		{
			[featureMap setObject:feature forKey:[feature uid]];
		}
		[self load];
	}
	return self;
}
-(void) readLine:(CSVReader*) reader{
	NSString* imageid = [reader getValue:COL_IMAGE_FEATURE_IMAGE_ID];
	NSString* featureid = [reader getValue:COL_IMAGE_FEATURE_FEATURE_ID];
	NSString* xString = [reader getValue:COL_IMAGE_FEATURE_X];
	NSString* yString = [reader getValue:COL_IMAGE_FEATURE_Y];
	int x = [ xString intValue];
	int y = [ yString intValue];
	Image* image = [imageMap objectForKey:imageid];
	Feature* feature = [featureMap objectForKey:featureid];
	[image addFeature:feature andX:x andY:y];
}
@end
