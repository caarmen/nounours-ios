//
//  Image.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feature.h"
#import "ImageFeature.h"

@interface Image : NSObject {
	@private NSString *uid;
	@private NSString *filename;
	@private NSString *onReleaseImageId;
	@private NSMutableDictionary *featureToPosition;
	@private NSMutableSet *features;
	@private NSMutableDictionary *adjacentImages;
	
}
-(Image*) initImage: (NSString*) puid andFilename: (NSString*) pfilename;
-(void) addFeature: (Feature*) pFeature andX: (int) px andY: (int) py;
-(ImageFeature*) getImageFeature: (NSString*) pfeatureId;
-(void) addAdjacentImage: (NSString*) pfeatureId andImage: (Image*) pimage;
-(NSSet*) getAdjacentImages: (NSString*) pfeatureId;
-(NSArray*) getAllAdjacentImages;

@property(retain,readonly) NSString *uid;
@property(retain,readonly) NSString *filename;
@property(retain,readonly) NSMutableSet *features;
@property(retain,readwrite) NSString *onReleaseImageId;
//@property(retain,readonly) NSMutableDictionary *adjacentImages;
//@property(retain,readonly) NSMutableDictionary *featureToPosition;
@end
