//
//  OrientationHandler.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/28/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Nounours.h"

@interface OrientationHandler : NSObject<UIAccelerometerDelegate> {
@private Nounours *nounours;
@private BOOL isTiltImage;
}
-(OrientationHandler*) initOrientationHandler:(Nounours*) pnounours;
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;
@end
