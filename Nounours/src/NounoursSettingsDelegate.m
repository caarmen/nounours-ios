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
    [settingsViewController dismissViewControllerAnimated:YES completion:nil];
	[nounours loadPreferences];
}
@end
