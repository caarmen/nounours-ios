//
//  OrientationHandler.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "Nounours.h"

@interface OrientationHandler : NSObject {
@private Nounours *nounours;
@private BOOL isTiltImage;
}
-(OrientationHandler*) initOrientationHandler:(Nounours*) pnounours;
-(void) doDeviceMotion:(CMAccelerometerData*) motion;
@end
