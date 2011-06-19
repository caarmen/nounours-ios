//
//  OrientationImageReader.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/28/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NounoursReader.h";

@interface OrientationImageReader : NounoursReader {
@private NSMutableSet *orientationImages;
}
-(OrientationImageReader*) initOrientationImageReader:(NSString*) pfilename;

@property (retain,readonly) NSMutableSet *orientationImages;
@end
