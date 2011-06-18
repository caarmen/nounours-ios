//
//  NounoursViewController.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../src/ui/MainView.h"
#import "Nounours.h"
#import "IASKAppSettingsViewController.h"
#import "NounoursSettingsDelegate.h"
@class NounoursSettingsDelegate;

@interface NounoursViewController : UIViewController {
@private MainView* mainView; 
@private Nounours *nounours;
@private IASKAppSettingsViewController *appSettingsViewController;
@private NounoursSettingsDelegate *nounoursSettingsDelegate;
@private UIActivityIndicatorView *activityView;
}
-(void) doLoad:(id) sender;
-(void) showSettings;
@property(retain,readonly) Nounours *nounours;
@property (nonatomic,retain) IASKAppSettingsViewController *appSettingsViewController;
@end

