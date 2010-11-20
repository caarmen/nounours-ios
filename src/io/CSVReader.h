//
//  CSVReader.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSVReader : NSObject {
	
	@private NSArray* header;
	@private NSArray* currentLine;
	@private int currentLineNumber;
	@private NSArray *wholeContents;
}

-(CSVReader*) initCSVReader:(NSString*) pfilename;
-(BOOL) next;
-(NSString*) getValue:(NSString*) pfieldName;
-(void) close;

@property(retain,readonly) NSArray* header;
@property(retain,readonly) NSArray* currentLine;
@property(readonly) int currentLineNumber;
@end
