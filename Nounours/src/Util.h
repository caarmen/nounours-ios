//
//  Util.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/19/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
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
