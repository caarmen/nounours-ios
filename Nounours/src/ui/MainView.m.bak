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

#import "MainView.h"
#import "../data/Animation.h"
#import "../data/Image.h"

@implementation MainView
@synthesize myImage;
@synthesize nounours;
@synthesize menuIconView;
@synthesize settingsIconView;
@synthesize imageCache;
- (id) initMainView:(CGRect) pframe withController:(NounoursViewController*) pnounoursViewController{
    if ((self = [super initWithFrame:pframe])) {
		nounoursViewController = pnounoursViewController;
		NSLog(@"MainView init begin");
		NSString *defaultImage = [[NSBundle mainBundle] pathForResource:@"Default" ofType:@"png"];
		[self setImageFromFilename:defaultImage];
		self.userInteractionEnabled = YES;
		self.autoresizesSubviews = NO;
		imageCache = [[NSMutableDictionary alloc] init];
		[self becomeFirstResponder];
		menu = [UIMenuController sharedMenuController];
		UIMenuItem *animationMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"actions",@"") action:@selector(animationMenuItemSelected:)];
		UIMenuItem *helpMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"help",@"") action:@selector(helpMenuItemSelected:)];
		UIMenuItem *themeMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"themes",@"") action:@selector(themeMenuItemSelected:)];
		UIMenuItem *aboutMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"about",@"") action:@selector(aboutMenuItemSelected:)];
		menu.menuItems = [NSArray arrayWithObjects:animationMenuItem, themeMenuItem, helpMenuItem,aboutMenuItem,nil];
		animationMenu = [AnimationMenu alloc];
		themeMenu = [ThemeMenu alloc];
		//aboutView = [[AboutView alloc] initWithFrame:[UIScreen mainScreen].bounds];
		NSLog(@"MainView init end");
    }
    return self;
}
-(void) useTheme:(Theme*) ptheme{
	[imageCache removeAllObjects];
	for(Image *image in [ptheme.images allValues])
	{
		[self setImageFromFilename:image.filename];
	}
	menuIconView = [self setupIcon:ptheme withIconFilename:@"menu.png" withImageView:menuIconView];
	settingsIconView = [self setupIcon:ptheme withIconFilename:@"settings.png" withImageView:settingsIconView];
}
-(UIImageView*) setupIcon:(Theme*) ptheme withIconFilename:(NSString*) piconFilename withImageView:(UIImageView*) pimageView {
    NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
	NSString *iconImagePath = [NSString stringWithFormat:@"%@/res/themes/%@/icons/%@", bundlePath, ptheme.uid, piconFilename];
	UIImage *icon = [UIImage imageWithContentsOfFile:iconImagePath];
	UIImageView *result = pimageView;
	if(result == nil)
	{
		result = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,0,0)];
		result.userInteractionEnabled = YES;
		[self addSubview:result];
		[self bringSubviewToFront:result];
	}
	[result setImage:icon];
	return result;
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
	
}
-(void) animationMenuItemSelected:(id) sender{
	UIAlertController *animationList = [animationMenu createAnimationList:nounours];
	[nounoursViewController presentViewController: animationList animated:YES completion:nil];
}

-(void) helpMenuItemSelected:(id)sender{
	[nounours displayImage:nounours.curTheme.helpImage];
}
-(void) themeMenuItemSelected:(id) sender{
	UIAlertController *themeList = [themeMenu createThemeList:nounours];
	[nounoursViewController presentViewController:themeList animated:YES completion:nil];
}
-(void) aboutMenuItemSelected:(id)sender{
	[nounoursViewController showAbout];
}
- (BOOL) canPerformAction:(SEL)selector withSender:(id) sender {
    if (selector == @selector(animationMenuItemSelected:) 
		|| selector == @selector(helpMenuItemSelected:)
		|| selector == @selector(themeMenuItemSelected:)
		|| selector == @selector(aboutMenuItemSelected:))
	{
        return YES;
    }
    return NO;
}
- (BOOL) canBecomeFirstResponder {
    return YES;
}

-(void) resizeView{
	CGRect newSize = [self getFrameRect];
	self.frame = newSize;
	[self setNeedsDisplay];
	CGFloat menuIconWidth = menuIconView.image.size.width;
	CGFloat menuIconHeight = menuIconView.image.size.height;
	CGRect menuIconSize = CGRectMake(newSize.size.width-menuIconWidth, 0, menuIconWidth, menuIconHeight);
	menuIconView.frame = menuIconSize;
	
	CGFloat settingsIconWidth = settingsIconView.image.size.width;
	CGFloat settingsIconHeight = settingsIconView.image.size.width;
	CGRect settingsIconSize = CGRectMake(0, 0, settingsIconWidth, settingsIconHeight);
	settingsIconView.frame = settingsIconSize;
	
}
- (CGRect) getFrameRect
{
	CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
	CGSize imageSize = [self getImageSize];
	CGRect wholeDeviceSize = [[UIScreen mainScreen ]bounds] ;
	CGRect deviceSize = CGRectMake(0, statusBarRect.size.height, wholeDeviceSize.size.width, wholeDeviceSize.size.height - statusBarRect.size.height);
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
	return newSize;
}

- (void) setFrame:(CGRect) frame
{
	if(nounours == nil)
	{
		[super setFrame:frame];
		return;
	}
	CGRect frameToUse = [self getFrameRect];
	if(CGRectEqualToRect(frameToUse, frame))
	   [super setFrame:frame];
}
@end
