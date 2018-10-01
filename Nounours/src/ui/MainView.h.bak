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

#import <UIKit/UIKit.h>
#import "../Nounours.h"
#import "AnimationMenu.h"
#import "../data/Theme.h"
#import "ThemeMenu.h"
#import "../NounoursViewController.h"

@class AnimationMenu;
@class ThemeMenu;
@class Theme;
@class NounoursViewController;
@interface MainView : UIImageView {
@private UIImage * curImage;
@private Nounours *nounours;
@private NSMutableDictionary *imageCache;
@private UIMenuController *menu;
@private NounoursViewController *nounoursViewController;
@private AnimationMenu *animationMenu;
@private ThemeMenu *themeMenu;
@private UIImageView *menuIconView;
@private UIImageView *settingsIconView;
}
-(id) initMainView:(CGRect) pframe withController:(NounoursViewController*) pnounoursViewController;
-(void) useTheme:(Theme*) ptheme;
-(void) setImageFromFilename:(NSString*) pfilename;
-(CGSize) getImageSize;
-(void) showMenu:(CGFloat) px withY:(CGFloat) py;
-(void) animationMenuItemSelected:(id) sender;
-(void) helpMenuItemSelected:(id) sender;
-(void) themeMenuItemSelected:(id) sender;
-(void) aboutMenuItemSelected:(id) sender;
-(void) resizeView;
-(CGRect) getFrameRect;
-(UIImageView*) setupIcon:(Theme*) ptheme withIconFilename:(NSString*) piconFilename withImageView:(UIImageView*) pimageView;

@property(retain,readwrite) UIImage* myImage;
@property(retain,readwrite) Nounours *nounours;
@property(retain,readwrite) UIImageView *menuIconView;
@property(retain,readwrite) UIImageView *settingsIconView;
@property (retain, readonly) NSMutableDictionary *imageCache;
@end
