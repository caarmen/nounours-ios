//
//  MainView.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Nounours.h"
#import "AnimationMenu.h"
#import "../data/Theme.h"
#import "ThemeMenu.h"
#import "AboutView.h"

@class AboutView;
@class AnimationMenu;
@class ThemeMenu;
@class Theme;
@interface MainView : UIImageView {
@private UIImage * curImage;
@private Nounours *nounours;
@private NSMutableDictionary *imageCache;
@private UIMenuController *menu;
@private AnimationMenu *animationMenu;
@private ThemeMenu *themeMenu;
@private UIImageView *menuIconView;
AboutView *aboutView;
}

-(void) useTheme:(Theme*) ptheme;
-(void) setImageFromFilename:(NSString*) pfilename;
-(CGSize) getImageSize;
-(void) showMenu:(CGFloat) px withY:(CGFloat) py;
-(void) animationMenuItemSelected:(id) sender;
-(void) helpMenuItemSelected:(id) sender;
-(void) themeMenuItemSelected:(id) sender;
-(void) aboutMenuItemSelected:(id) sender;
-(void) resizeView;
@property(retain,readwrite) UIImage* myImage;
@property(retain,readwrite) Nounours *nounours;
@property(retain,readwrite) UIImageView *menuIconView;
@property (assign) IBOutlet AboutView *aboutView;
@property (retain, readonly) NSMutableDictionary *imageCache;
@end
