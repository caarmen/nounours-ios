//
//  Util.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Util.h"
#import "data/ImageFeature.h"


@implementation Util
+(Feature*) getClosestFeature:(Image*) pimage withX:(CGFloat) px withY:(CGFloat) py{
	Feature* result = nil;
	CGFloat minDistance = (CGFloat) CGFLOAT_MAX;
	NSSet *features = [pimage features];
	for(Feature *feature in features)
	{
		CGFloat distance = [Util getDistance:pimage withFeatureId:feature.uid withX:px withY:py];
		if(distance <minDistance)
		{
			minDistance = distance;
			result = feature;
		}
	}
	return result;
}
+(CGPoint) translate:(CGFloat) pdeviceX withDeviceY:(CGFloat) pdeviceY withDeviceWidth:(CGFloat)pdeviceWidth withDeviceHeight:(CGFloat)pdeviceHeight withImageWidth:(CGFloat)pimageWidth withImageHeight:(CGFloat)pimageHeight{
	CGFloat heightRatio = pdeviceHeight / pimageHeight;
	CGFloat widthRatio = pdeviceWidth / pimageWidth;
	CGFloat ratioToUse = heightRatio > widthRatio ? widthRatio : heightRatio;
	CGFloat offsetX = 0;
	CGFloat offsetY = 0;
	if(heightRatio > widthRatio) {
		offsetY = (CGFloat) ((pdeviceHeight - ratioToUse*pimageHeight)/2);
	}
	else {
		offsetX = (CGFloat) ((pdeviceWidth - ratioToUse * pimageWidth) / 2);
	}
	CGFloat translatedX = (CGFloat) ((pdeviceX - offsetX)/ratioToUse);
	CGFloat translatedY = (CGFloat) ((pdeviceY - offsetY)/ratioToUse);
	CGPoint result = CGPointMake(translatedX, translatedY);
	return result;
		 
}
+(Image*) getAdjacentImage:(Image*)pimage withFeatureId:(NSString*) pfeatureId withX:(CGFloat) px withY:(CGFloat) py{
	Image *result = pimage;
	CGFloat minDistance = [Util getDistance:pimage withFeatureId:pfeatureId withX:px withY:py];
	NSSet * adjacentImages = [pimage getAdjacentImages:pfeatureId];
	for(Image * adjImage in adjacentImages){
		CGFloat distance = [Util getDistance:adjImage withFeatureId:pfeatureId withX:px withY:py];
		if(distance < minDistance){
			minDistance = distance;
			result = adjImage;
		}
	}
	return result;
}
+(CGFloat) getDistance:(Image*)pimage withFeatureId:(NSString*) pfeatureId withX:(CGFloat) px withY:(CGFloat) py{
	ImageFeature *featureImage = [pimage getImageFeature:pfeatureId];
	if(featureImage == nil)
	{
		return (CGFloat) CGFLOAT_MAX;
	}
	CGFloat distance = [Util getDistance:featureImage.x withY1:featureImage.y withX2:px withY2:py];
	return distance;
}
+(CGFloat) getDistance:(CGFloat) px1 withY1:(CGFloat) py1 withX2:(CGFloat)px2 withY2:(CGFloat)py2{
	return (CGFloat) sqrt(powf(px1 - px2, 2.0) + powf(py2 - py1,2.0) );
}
+(BOOL) pointIsInSquare:(CGFloat)ppointX withPointY:(CGFloat)ppointY withSquareX:(CGFloat) psquareX withSquareY:(CGFloat) psquareY withSquareWidth:(CGFloat) psquareWidth withSquareHeight:(CGFloat) psquareHeight{
	if(ppointX >= psquareX && ppointX<= (psquareX + psquareWidth) && ppointY >= psquareY
	   && ppointY <= (psquareY + psquareHeight))
		return YES;
	return NO;
}
+(BOOL) isFaster:(CGFloat) v1 withV2:(CGFloat) v2{
	if(v2 <= 0 && v1 <= v2)
		return YES;
	if(v2>=0 && v1 >= v2)
		return YES;
	return NO;
}
+(CGFloat) getTimeIntervalProperty:(NSMutableDictionary*) pproperties withKey:(NSString*) pkey withDefaultValue:(CGFloat) defaultValue{
	NSString *value = [pproperties objectForKey:pkey];
	if(value == nil)
		return defaultValue;
	NSInteger intValue = [value intValue];
	CGFloat floatValue = (CGFloat) intValue / 1000.0f;
	return floatValue;
}
@end
