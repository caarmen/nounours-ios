//
//  NounoursViewController.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//
#ifndef NOUNOURS_VIEW_CONTROLLER_H
#define NOUNOURS_VIEW_CONTROLLER_H
#import <UIKit/UIKit.h>
#import "../src/ui/MainView.h"
#import "ui/AboutView.h"
#import "Nounours.h"
#import "InAppSettingsKit/IASKAppSettingsViewController.h"
#import "NounoursSettingsDelegate.h"
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
