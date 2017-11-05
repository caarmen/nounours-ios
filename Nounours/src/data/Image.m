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

#import "Image.h"


@implementation Image

@synthesize uid;
@synthesize filename;
@synthesize onReleaseImageId;
@synthesize features;
//@synthesize featureToPosition;
//@synthesize adjacentImages;

-(Image*) initImage: (NSString*) puid andFilename: (NSString*) pfilename {
	self = [super init];
	if (self) {
		uid = puid;
		filename = pfilename;
		featureToPosition = [[NSMutableDictionary alloc] init];
		features = [[NSMutableSet alloc] init];
		adjacentImages = [[NSMutableDictionary alloc] init];
	}
	return self;
}
-(void) addFeature: (Feature*) pfeature andX: (int) px andY: (int) py{
	[features addObject:pfeature];
	ImageFeature* imageFeature = [[ImageFeature alloc] initImageFeature:uid andFeatureId:[pfeature uid] andX:px andY:py];
	[featureToPosition setObject:imageFeature forKey:[pfeature uid]];
}
-(ImageFeature*) getImageFeature: (NSString*) pfeatureId
{
	return [featureToPosition objectForKey:pfeatureId];
}
-(void) addAdjacentImage: (NSString*) pfeatureId andImage: (Image*) pimage
{
	NSMutableSet* images = [adjacentImages objectForKey:pfeatureId];
	if(images == nil)
	{
		images = [[NSMutableSet alloc] init];
		[adjacentImages setObject:images forKey:pfeatureId];
	}
	if(![images containsObject:pimage])
	{
		[images addObject:pimage];
	}
	NSSet* reverseAdjacentImages = [pimage getAdjacentImages:pfeatureId];
	if(![reverseAdjacentImages containsObject:self])
	{
		[pimage addAdjacentImage:pfeatureId andImage:self];
	}
}
-(NSSet*) getAdjacentImages: (NSString*) pfeatureId{
	NSSet *result = [adjacentImages objectForKey:pfeatureId];
	if(result == nil)
	{
		result = [[NSSet alloc] init];
	}
	return result;
}
-(NSArray*) getAllAdjacentImages{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	for(NSSet* images in [adjacentImages allValues])
	{
		for(Image *image in images)
		{
			[result addObject: image];
		}
	}
	return result;
}
- (NSString *)description{
	return [NSString stringWithFormat:@"%@: %@,%@",
			NSStringFromClass(self.class),uid,filename];
}

@end
