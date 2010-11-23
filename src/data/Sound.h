//
//  Sound.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Sound : NSObject {
@private NSString* uid;
@private NSString* filename;
}

-(Sound*) initSound:(NSString*) puid withFilename:(NSString*) pfilename;
@property(retain,readonly) NSString* uid;
@property(retain,readonly) NSString* filename;
@end
