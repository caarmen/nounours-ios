//
//  MainView.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Nounours.h"

@interface MainView : UIImageView {
@private UIImage * curImage;
@private Nounours *nounours;
@private NSMutableDictionary *imageCache;
@private UIMenuController *menu;
}
-(void) setImageFromFilename:(NSString*) pfilename;
-(CGSize) getImageSize;
-(void) showMenu:(CGFloat) px withY:(CGFloat) py;
-(void) animationMenuItemSelected:(id) sender;
-(void) helpMenuItemSelected:(id) sender;
@property(retain,readwrite) UIImage* myImage;
@property(retain,readwrite) Nounours *nounours;
@end
