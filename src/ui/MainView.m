//
//  MainView.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainView.h"
#import "../data/Animation.h"
#import "../data/Image.h"

@implementation MainView
@synthesize myImage;
@synthesize nounours;
@synthesize menuIconView;
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.userInteractionEnabled = YES;
		self.autoresizesSubviews = NO;
		imageCache = [[NSMutableDictionary alloc] init];
		[self becomeFirstResponder];
		menu = [UIMenuController sharedMenuController];
		UIMenuItem *animationMenuItem = [[UIMenuItem alloc] initWithTitle:@"Animations" action:@selector(animationMenuItemSelected:)];
		UIMenuItem *helpMenuItem = [[UIMenuItem alloc] initWithTitle:@"Help" action:@selector(helpMenuItemSelected:)];
		UIMenuItem *themeMenuItem = [[UIMenuItem alloc] initWithTitle:@"Themes" action:@selector(themeMenuItemSelected:)];
		menu.menuItems = [NSArray arrayWithObjects:animationMenuItem, themeMenuItem, helpMenuItem,nil];
		animationMenu = [[AnimationMenu alloc] initAnimationMenu:self];
		themeMenu = [[ThemeMenu alloc] initThemeMenu:self];
    }
    return self;
}
-(void) useTheme:(Theme*) ptheme{
	[imageCache removeAllObjects];
	for(Image *image in [ptheme.images allValues])
	{
		[self setImageFromFilename:image.filename];
	}
    NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
	NSString *menuIconImagePath = [NSString stringWithFormat:@"%@/themes/%@/icons/%@",bundlePath,ptheme.uid,@"menu.png"];
	NSLog(@"icon path=%@",menuIconImagePath);
	UIImage *menuIcon = [UIImage imageWithContentsOfFile:menuIconImagePath];
	if(menuIconView == nil)
	{
		menuIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,0,0)];
		menuIconView.userInteractionEnabled = YES;
		[self addSubview:menuIconView];
		[self bringSubviewToFront:menuIconView];

	}
	[menuIconView setImage:menuIcon];
	
	NSLog(@"menu icon at %f,%f  %f,%f",(curImage.size.width - menuIcon.size.width),0,menuIcon.size.width, menuIcon.size.height);
	
}
-(void) setImageFromFilename:(NSString*) pfilename{
	UIImage *img = [imageCache objectForKey:pfilename];
	if(img == nil)
	{
		img = [UIImage imageWithContentsOfFile:pfilename];
		if(img != nil)
		{
			[imageCache setObject:img forKey:pfilename];
		}
		else {
			NSLog(@"Can't find image %@!",pfilename);
		}

	}

	curImage = img;
	if(curImage != nil)
		[self setImage:curImage];
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
-(void) themeMenuItemSelected:(id) sender{
	NSLog(@"Animations");
	[themeMenu showActionSheet:sender];
}
- (BOOL) canPerformAction:(SEL)selector withSender:(id) sender {
    if (selector == @selector(animationMenuItemSelected:) 
		|| selector == @selector(helpMenuItemSelected:)
		|| selector == @selector(themeMenuItemSelected:)) {
        return YES;
    }
    return NO;
}
- (BOOL) canBecomeFirstResponder {
    return YES;
}

-(void) resizeView{
	CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
	CGSize imageSize = [self getImageSize];
	CGRect wholeDeviceSize = [[UIScreen mainScreen ]bounds] ;
	CGRect deviceSize = CGRectMake(0, statusBarRect.size.height, wholeDeviceSize.size.width, wholeDeviceSize.size.height - statusBarRect.size.height);
	NSLog(@"Status bar: %fx%f %fx%f",statusBarRect.origin.x,statusBarRect.origin.y,statusBarRect.size.width,statusBarRect.size.height);
	CGFloat widthRatio = deviceSize.size.width / imageSize.width;
	CGFloat heightRatio = deviceSize.size.height / imageSize.height;
	CGFloat ratioToUse = widthRatio > heightRatio ? heightRatio : widthRatio;
	CGFloat width = ratioToUse*imageSize.width;
	CGFloat height = ratioToUse*imageSize.height;
	CGFloat offsetX = deviceSize.origin.x;
	CGFloat offsetY = deviceSize.origin.y;
	if(heightRatio > widthRatio) {
		offsetY += 0;//(CGFloat) ((deviceSize.size.height - ratioToUse*imageSize.height)/2);
	}
	else {
		offsetX += (CGFloat) ((deviceSize.size.width - ratioToUse * imageSize.width) / 2);
	}
	
	CGRect newSize = CGRectMake(offsetX, offsetY, width, height);
	self.frame = newSize;
	CGFloat iconWidth = menuIconView.image.size.width;
	CGFloat iconHeight = menuIconView.image.size.height;
	CGRect menuIconSize = CGRectMake(width-iconWidth, 0, iconWidth, iconHeight);
	menuIconView.frame = menuIconSize;
	NSLog(@"icon: %f,%f %f,%f",menuIconView.bounds.origin.x,menuIconView.bounds.origin.y,menuIconView.image.size.width,menuIconView.image.size.height);
}

- (void)dealloc {
    [super dealloc];
}
@end
