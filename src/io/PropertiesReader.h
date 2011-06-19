//
//  PropertiesReader.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/25/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PropertiesReader : NSObject {
@private NSMutableDictionary* data;
}
-(PropertiesReader*) initPropertiesReader:(NSString*) pfilename;
@property(retain,readonly) NSMutableDictionary* data;
@end
