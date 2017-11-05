//
//  NounoursSettingsDelegate.m
//  Nounours
//
//  Created by Carmen Alvarez on 6/18/11.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import "NounoursSettingsDelegate.h"


@implementation NounoursSettingsDelegate
-(NounoursSettingsDelegate*) initNounoursSettingsDelegate:(IASKAppSettingsViewController*) pcontroller withNounours:(Nounours*) pnounours
{
	self = [super init];
	settingsViewController = pcontroller;
	return self;
}

#pragma mark -
#pragma mark IASKAppSettingsViewControllerDelegate protocol
- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender {
    [settingsViewController dismissModalViewControllerAnimated:YES];
	
	[nounours loadPreferences];
}
@end
