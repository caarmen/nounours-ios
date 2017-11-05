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

#import "CSVReader.h"


@implementation CSVReader
@synthesize header;
@synthesize currentLine;
@synthesize currentLineNumber;
NSString * const FIELD_SEPARATOR = @",";

-(CSVReader*) initCSVReader:(NSString*) pfilename{
	self = [super init];
	
	NSString *path = pfilename;
	NSString *wholeContentsStr = [NSString stringWithContentsOfFile:path encoding:NSISOLatin2StringEncoding error:NULL];
	lineSeparator = @"\r\n";
	NSRange firstLineEnd = [wholeContentsStr rangeOfString:lineSeparator];
	if(firstLineEnd.length == 0)
		lineSeparator = @"\n";
	wholeContents = [wholeContentsStr componentsSeparatedByString:lineSeparator];
	
	if([wholeContents count]>0)
	{
		NSString * headerStr = [wholeContents objectAtIndex:0];
		header = [headerStr componentsSeparatedByString:FIELD_SEPARATOR];
	}
	return self;
}
-(BOOL) next{
	currentLineNumber++;

	while([wholeContents count] > currentLineNumber)
	{
		NSString *currentLineStr = [wholeContents objectAtIndex:currentLineNumber];
		currentLineStr = [currentLineStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		if([currentLineStr length] == 0)
		{
			currentLineNumber++;
			continue;
		}
		currentLine = [currentLineStr componentsSeparatedByString:FIELD_SEPARATOR];
		return YES;
	}
	
	return NO;
	

}


-(NSString*) getValue:(NSString*) pfieldName{
	if(currentLineNumber <1)
		return nil;
	int column = 0;
	for(;column < [header count]; column++)
	{
		NSString *columnStr = [header objectAtIndex:column];
		if([columnStr isEqualToString: pfieldName])
			break;
		
	}
	if(column >= [currentLine count])
		return nil;
	NSString *result = [currentLine objectAtIndex:column];
	return result;
}
-(void) close{
	//Don't need to release anything here
	/*[m_header release];
	[m_wholeContents release];
	[m_currentLine release];*/
}
@end
