//
//  AnimationMenu.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimationMenu.h"
#include <stdlib.h>

@implementation AnimationMenu
-(AnimationMenu*) initAnimationMenu:(MainView*) pmainView
{
	[super init];
	mainView = pmainView;
	return self;
}
-(void) reset {
	if(animationList != nil)
	{
		[animationList release];
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
		[animationList addButtonWithTitle:@"Cancel"];
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
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
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
	[pool release];
}
@end
