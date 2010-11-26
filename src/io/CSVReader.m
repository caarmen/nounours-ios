//
//  CSVReader.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CSVReader.h"


@implementation CSVReader
@synthesize header;
@synthesize currentLine;
@synthesize currentLineNumber;
NSString * const FIELD_SEPARATOR = @",";
NSString * const LINE_SEPARATOR = @"\r\n";

-(CSVReader*) initCSVReader:(NSString*) pfilename{
	[super init];
	
	NSString *path = pfilename;//[[NSBundle mainBundle] pathForResource:pfilename ofType:@"csv"];
	NSLog(@"path = %@",path);
	NSString *wholeContentsStr = [NSString stringWithContentsOfFile:path encoding:NSISOLatin2StringEncoding error:NULL];
	wholeContents = [wholeContentsStr componentsSeparatedByString:LINE_SEPARATOR];
	if([wholeContents count]>0)
	{
		NSString * headerStr = [wholeContents objectAtIndex:0];
		header = [headerStr componentsSeparatedByString:FIELD_SEPARATOR];
	}
	return self;
}
-(BOOL) next{
	currentLineNumber++;
	if([wholeContents count] > currentLineNumber)
	{
		NSString *currentLineStr = [wholeContents objectAtIndex:currentLineNumber];
		currentLine = [currentLineStr componentsSeparatedByString:FIELD_SEPARATOR];
		return YES;
	}
	else {
		return NO;
	}

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
