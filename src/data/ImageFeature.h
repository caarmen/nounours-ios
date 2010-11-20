//
//  ImageFeature.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
//  This class contains information about a given feature in the context of a 
//  given image. For now, only the position of the feature in the image is
//  stored.
#import <Foundation/Foundation.h>


@interface ImageFeature : NSObject {
	@private NSString *featureId;
	@private NSString *imageId;
	@private int x;
	@private int y;
}
- (ImageFeature*) initImageFeature:(NSString*)pimageId andFeatureId:(NSString*)pfeatureId andX:(int)px andY:(int)py;

@property(retain,readonly) NSString *featureId;
@property(retain,readonly) NSString *imageId;
@property(readonly) int x;
@property(readonly) int y;
@end
