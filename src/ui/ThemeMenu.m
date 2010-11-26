//
//  ThemeMenu.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ThemeMenu.h"
#import "../data/Theme.h"

@implementation ThemeMenu
-(ThemeMenu*) initThemeMenu:(MainView*) pmainView
{
	[super init];
	mainView = pmainView;
	return self;
}
-(IBAction)showActionSheet:(id)sender{
	UIActionSheet *themeList = [[UIActionSheet alloc] initWithTitle:@"Themes" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	
	for(Theme* theme in [mainView.nounours.themes allValues])
	{
		[themeList addButtonWithTitle:theme.name];
	}
	themeList.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[themeList addButtonWithTitle:@"Cancel"];
	themeList.cancelButtonIndex = themeList.numberOfButtons - 1;
    [themeList showInView:mainView];
    [themeList release];
	
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
