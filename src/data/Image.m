//
//  Image.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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
		filename = [pfilename retain];
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
