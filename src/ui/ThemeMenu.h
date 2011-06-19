//
//  ThemeMenu.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/26/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Nounours.h"
#import "MainView.h"
@class MainView;

@interface ThemeMenu : UIViewController<UIActionSheetDelegate> {
@private MainView *mainView;
}
-(ThemeMenu*) initThemeMenu:(MainView*) pmainView;
-(IBAction)showActionSheet:(id)sender;
@end
