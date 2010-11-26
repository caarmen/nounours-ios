//
//  MainView.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainView.h"


@implementation MainView
@synthesize myImage;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		//image = [UIImage imageNamed:@"Default.png"];
		//[image drawAtPoint:(CGPointMake(0.0, 0.0))];
		self.userInteractionEnabled = YES;
		self.autoresizesSubviews = NO;
		imageCache = [[NSMutableDictionary alloc] init];

    }
    return self;
}
-(void) setImageFromFilename:(NSString*) pfilename{
	NSLog(@"setImageFromFilename:%@",pfilename);
	UIImage *img = [imageCache objectForKey:pfilename];
	if(img == nil)
	{
		img = [UIImage imageWithContentsOfFile:pfilename];
		if(img != nil)
		{
			[imageCache setObject:img forKey:pfilename];
			//NSLog(@"Saving to cache");
		}
		else {
			NSLog(@"Can't find image %@!",pfilename);
		}

	}
	else {
		//NSLog(@"Loaded from cache");
	}

	curImage = img;
	if(curImage != nil)
	{
		[self setImage:curImage];
		//[image drawAtPoint:(CGPointMake(0.0, 0.0))];
		//[self setNeedsDisplay];

	}
}

-(CGSize) getImageSize{
	if(curImage == nil)
		return CGSizeMake(0.0,0.0);
	return curImage.size;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
