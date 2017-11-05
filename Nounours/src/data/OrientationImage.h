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
#import <CoreGraphics/CoreGraphics.h>


@interface OrientationImage : NSObject {
@private NSString *imageId;
@private CGFloat minYaw;
@private CGFloat maxYaw;
@private CGFloat minPitch;
@private CGFloat maxPitch;
@private CGFloat minRoll;
@private CGFloat maxRoll;
}
-(OrientationImage*) initOrientationImage:(NSString*) pimageId withMinYaw:(CGFloat) pminYaw withMaxYaw:(CGFloat) pmaxYaw withMinPitch:(CGFloat) pminPitch withMaxPitch:(CGFloat) pmaxPitch withMinRoll:(CGFloat) pminRoll withMaxRoll:(CGFloat) pmaxRoll;

@property(retain,readonly) NSString *imageId;
@property(readonly) CGFloat minYaw;
@property(readonly) CGFloat maxYaw;
@property(readonly) CGFloat minPitch;
@property(readonly) CGFloat maxPitch;
@property(readonly) CGFloat minRoll;
@property(readonly) CGFloat maxRoll;

@end
