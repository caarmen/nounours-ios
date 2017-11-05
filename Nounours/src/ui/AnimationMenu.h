//
//  AnimationMenu.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/26/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Nounours.h"
#import "MainView.h"
@class MainView;
@interface AnimationMenu : UIViewController<UIActionSheetDelegate> {
@private MainView *mainView;
@private UIActionSheet *animationList;
}
-(AnimationMenu*) initAnimationMenu:(MainView*) pmainView;
-(void) doAnimation:(NSString*)panimationLabel;
-(IBAction)showActionSheet:(id)sender;
-(void) reset;

@end
