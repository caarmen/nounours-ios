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
