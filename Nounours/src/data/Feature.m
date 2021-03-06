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

#import "Feature.h"


@implementation Feature

@synthesize uid;
@synthesize featureName;

-(Feature*) initFeature : (NSString*) puid andName: (NSString*) pname{
	self = [super init];
	if (self) {
		uid = puid;
		featureName = pname;
	}
	return self;
}
- (NSString *)description{
	return [NSString stringWithFormat:@"%@: %@,%@",
		   NSStringFromClass(self.class),uid,featureName];
}
@end
