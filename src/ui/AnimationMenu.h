//
//  AnimationMenu.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Nounours.h"
#import "MainView.h"
@class MainView;
@interface AnimationMenu : UIViewController<UIActionSheetDelegate> {
@private MainView *mainView;
}
-(AnimationMenu*) initAnimationMenu:(MainView*) pmainView;
-(void) doAnimation:(NSString*)panimationLabel;
-(IBAction)showActionSheet:(id)sender;

@end
