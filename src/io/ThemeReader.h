//
//  ThemeReader.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NounoursReader.h"

@interface ThemeReader : NounoursReader {
@private NSMutableDictionary *themes;
}

-(ThemeReader*) initThemeReader:(NSString *) pfilename;

@property(retain,readonly) NSMutableDictionary *themes;
@end
