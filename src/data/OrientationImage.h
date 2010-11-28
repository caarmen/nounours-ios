//
//  OrientationImage.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


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
