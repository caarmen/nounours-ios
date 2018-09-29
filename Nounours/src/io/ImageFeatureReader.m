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
	self = [super initNounoursReader:pfileName];
	if(self)
	{
		imageMap = pimageMap;
		featureMap = [[NSMutableDictionary alloc] init];
		for(Feature* feature in pfeatures)
		{
			[featureMap setObject:feature forKey:[feature uid]];
		}
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
