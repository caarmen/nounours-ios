//
//  MainView.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainView.h"
#import "../data/Animation.h"

@implementation MainView
@synthesize myImage;
@synthesize nounours;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		//image = [UIImage imageNamed:@"Default.png"];
		//[image drawAtPoint:(CGPointMake(0.0, 0.0))];
		self.userInteractionEnabled = YES;
		self.autoresizesSubviews = NO;
		imageCache = [[NSMutableDictionary alloc] init];
		[self becomeFirstResponder];
		menu = [UIMenuController sharedMenuController];
		UIMenuItem *animationMenuItem = [[UIMenuItem alloc] initWithTitle:@"Animations" action:@selector(animationMenuItemSelected:)];
		UIMenuItem *helpMenuItem = [[UIMenuItem alloc] initWithTitle:@"Help" action:@selector(helpMenuItemSelected:)];
		menu.menuItems = [NSArray arrayWithObjects:animationMenuItem, helpMenuItem,nil];
		animationMenu = [[AnimationMenu alloc] initAnimationMenu:self];
    }
    return self;
}
-(void) setImageFromFilename:(NSString*) pfilename{
	//NSLog(@"setImageFromFilename:%@",pfilename);
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
-(void) showMenu:(CGFloat) px withY:(CGFloat) py{
//	NSMutableArray * menuItems = [[NSMutableArray alloc] init];
	if(![self becomeFirstResponder])
	{
		NSLog(@"Could not become first responder");
	}
	
	[menu setTargetRect:CGRectMake(px,py,0,0) inView:self];
	[menu setMenuVisible:YES animated:YES];
	NSLog(@"menu width %f, visible %d", menu.menuFrame.size.width, menu.menuVisible);				
	
}
-(void) animationMenuItemSelected:(id) sender{
	NSLog(@"Animations");
	[animationMenu showActionSheet:sender];
}
-(void) helpMenuItemSelected:(id)sender{
	NSLog(@"Help");
	[nounours displayImage:nounours.curTheme.helpImage];
}
- (BOOL) canPerformAction:(SEL)selector withSender:(id) sender {
    if (selector == @selector(animationMenuItemSelected:) || selector == @selector(helpMenuItemSelected:) ) {
        return YES;
    }
    return NO;
}
- (BOOL) canBecomeFirstResponder {
    return YES;
}
- (void)dealloc {
    [super dealloc];
}
@end
