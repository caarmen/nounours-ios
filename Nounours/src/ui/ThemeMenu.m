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

#import "ThemeMenu.h"
#import "../data/Theme.h"

@implementation ThemeMenu
-(ThemeMenu*) initThemeMenu:(MainView*) pmainView
{
	self = [super init];
	mainView = pmainView;
	return self;
}
-(IBAction)showActionSheet:(id)sender{
	UIActionSheet *themeList = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"themes",@"") delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	
	for(Theme* theme in [mainView.nounours.themes allValues])
	{
		[themeList addButtonWithTitle:theme.name];
	}
	themeList.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[themeList addButtonWithTitle:NSLocalizedString(@"cancel",@"")];
	themeList.cancelButtonIndex = themeList.numberOfButtons - 1;
    [themeList showInView:mainView];	
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(buttonIndex == actionSheet.cancelButtonIndex)
		return;
	NSString *themeName = [actionSheet buttonTitleAtIndex:(buttonIndex)];
	Theme *selectedTheme = nil;
	for(Theme * theme in [mainView.nounours.themes allValues])
	{
		if([themeName isEqualToString:theme.name])
		{
			selectedTheme = theme;
			break;
		}
	}
	if(selectedTheme != nil)
		[mainView.nounours useTheme:selectedTheme.uid];
	
}
@end
