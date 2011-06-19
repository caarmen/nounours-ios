//
//  ImageFeature.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import "ImageFeature.h"


@implementation ImageFeature

@synthesize imageId;
@synthesize featureId;
@synthesize x;
@synthesize y;

-(ImageFeature*) initImageFeature:(NSString *)pimageId andFeatureId:(NSString *)pfeatureId andX:(int)px andY:(int)py {
	self = [super init];
	if(self){
		featureId = pfeatureId;
		imageId = pimageId;
		x = px;
		y = py;
	}
	return self;
}
@end
