//
//  Feature.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
//  This class represents a feature of the main object in an image. For example:
//  The left paw of Nounours.

#import <Foundation/Foundation.h>


@interface Feature : NSObject {
	@private NSString *uid;
	@private NSString *featureName;
}
-(Feature*) initFeature : (NSString*) puid andName: (NSString*) pname;

@property(retain, readonly) NSString *uid;
@property(retain, readonly) NSString *featureName;

@end
