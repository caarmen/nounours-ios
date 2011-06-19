//
//  VibrateHandler.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/27/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VibrateHandler : NSObject {

}
-(VibrateHandler*) initVibrateHandler;
-(void) doVibrate:(NSDictionary*) pdurationAndInterval;
-(void) doVibrate:(long) pduration withInterval:(CGFloat) pinterval;
@end
