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
