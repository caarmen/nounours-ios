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
