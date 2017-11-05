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

#import "AnimationMenu.h"
#include <stdlib.h>

@implementation AnimationMenu
-(AnimationMenu*) initAnimationMenu:(MainView*) pmainView
{
	self = [super init];
	mainView = pmainView;
	return self;
}
-(void) reset {
	if(animationList != nil)
	{
		animationList = nil;
	}
}
-(IBAction)showActionSheet:(id)sender{
	if(animationList == nil)
	{
		animationList = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"actions",@"") delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
		[animationList addButtonWithTitle:NSLocalizedString(@"random",@"")];
		for(Animation * animation in [mainView.nounours.curTheme.animations allValues])
		{
			if(animation.visible)
				[animationList addButtonWithTitle:animation.label];
		}
		animationList.actionSheetStyle = UIActionSheetStyleBlackOpaque;
		[animationList addButtonWithTitle:NSLocalizedString(@"cancel",@"")];
		animationList.cancelButtonIndex = animationList.numberOfButtons - 1;
	}
    [animationList showInView:mainView];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(buttonIndex == actionSheet.cancelButtonIndex)
		return;
	NSInteger animationIndex = buttonIndex;
	if(animationIndex == 0)
	{
		animationIndex = (arc4random() %(actionSheet.numberOfButtons - 2)) +1;
	}
	NSString *animationLabel = [actionSheet buttonTitleAtIndex:(animationIndex)];
	[self performSelectorInBackground:@selector(doAnimation:) withObject:animationLabel];
	
}
-(void) doAnimation:(NSString*)panimationLabel{
    @autoreleasepool {
        Animation *selectedAnimation = nil;
        for(Animation * animation in [mainView.nounours.curTheme.animations allValues])
        {
            if([panimationLabel isEqualToString:animation.label])
            {
                selectedAnimation = animation;
                break;
            }
        }
        if(selectedAnimation != nil)
        {
            [mainView.nounours doAnimation:selectedAnimation.uid];
        }
    }
}
@end
