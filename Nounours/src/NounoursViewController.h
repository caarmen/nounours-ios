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

#ifndef NOUNOURS_VIEW_CONTROLLER_H
#define NOUNOURS_VIEW_CONTROLLER_H
#import <UIKit/UIKit.h>
#import "../src/ui/MainView.h"
#import "ui/AboutView.h"
#import "Nounours.h"
#import "InAppSettingsKit/IASKAppSettingsViewController.h"
#import "NounoursSettingsDelegate.h"
@class MainView;
@class NounoursSettingsDelegate;

@interface NounoursViewController : UIViewController {
@private MainView* mainView; 
@private Nounours *nounours;
@private IASKAppSettingsViewController *appSettingsViewController;
@private UIViewController *aboutViewController;
@private NounoursSettingsDelegate *nounoursSettingsDelegate;
@private UIActivityIndicatorView *activityView;
@private AboutView __weak *aboutView;

}
-(void) doLoad:(id) sender;
-(void) showSettings;
-(void) showAbout;
@property(retain,readonly) Nounours *nounours;
@property (nonatomic,retain) IASKAppSettingsViewController *appSettingsViewController;
@property (nonatomic,retain) UIViewController *aboutViewController;
@property (weak) IBOutlet AboutView *aboutView;
@end
#endif
