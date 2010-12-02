//
//  OrientationHandler.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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
