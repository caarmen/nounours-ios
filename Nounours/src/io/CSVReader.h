//
// Copyright (c) 2010 - 2011 Carmen Alvarez
//
// This file is part of Nounours for iOS.
//
// Nounours for iOS is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Nounours for iOS is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Nounours for iOS.  If not, see <http://www.gnu.org/licenses/>.
//

#import <Foundation/Foundation.h>

@interface CSVReader : NSObject {
	
	@private NSArray* header;
	@private NSArray* currentLine;
	@private int currentLineNumber;
	@private NSArray *wholeContents;
@private NSString *lineSeparator;
}

-(CSVReader*) initCSVReader:(NSString*) pfilename;
-(BOOL) next;
-(NSString*) getValue:(NSString*) pfieldName;
-(void) close;

@property(retain,readonly) NSArray* header;
@property(retain,readonly) NSArray* currentLine;
@property(readonly) int currentLineNumber;
@end
