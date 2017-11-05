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
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "data/Feature.h"
#import "data/Image.h"

@interface Util : NSObject {
}
+(Feature*) getClosestFeature:(Image*) pimage withX:(CGFloat) px withY:(CGFloat) py;
+(CGPoint) translate:(CGFloat) pdeviceX withDeviceY:(CGFloat) pdeviceY withDeviceWidth:(CGFloat)pdeviceWidth withDeviceHeight:(CGFloat)pdeviceHeight withImageWidth:(CGFloat)pimageWidth withImageHeight:(CGFloat)pimageHeight;
+(Image*) getAdjacentImage:(Image*)pimage withFeatureId:(NSString*) pfeatureId withX:(CGFloat) px withY:(CGFloat) py;
+(CGFloat) getDistance:(Image*)pimage withFeatureId:(NSString*) pfeatureId withX:(CGFloat) px withY:(CGFloat) py;
+(CGFloat) getDistance:(CGFloat) px1 withY1:(CGFloat) py1 withX2:(CGFloat)px2 withY2:(CGFloat)py2;
+(BOOL) pointIsInSquare:(CGFloat)ppointX withPointY:(CGFloat)ppointY withSquareX:(CGFloat) psquareX withSquareY:(CGFloat) psquareY withSquareWidth:(CGFloat) psquareWidth withSquareHeight:(CGFloat) psquareHeight;
+(BOOL) isFaster:(CGFloat) v1 withV2:(CGFloat) v2;
+(CGFloat) getTimeIntervalProperty:(NSMutableDictionary*) pproperties withKey:(NSString*) pkey withDefaultValue:(CGFloat) defaultValue;

@end
