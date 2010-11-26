//
//  AnimationMenu.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimationMenu.h"


@implementation AnimationMenu
-(AnimationMenu*) initAnimationMenu:(MainView*) pmainView
{
	[super init];
	mainView = pmainView;
	animationList = nil;
	return self;
}

-(IBAction)showActionSheet:(id)sender{
	//if(animationList == nil)
	//{
		animationList = [[UIActionSheet alloc] initWithTitle:@"Animations" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
		
		for(Animation * animation in [mainView.nounours.curTheme.animations allValues])
		{
			[animationList addButtonWithTitle:animation.label];
		}
		animationList.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	//}
	[animationList addButtonWithTitle:@"Cancel"];
	animationList.cancelButtonIndex = animationList.numberOfButtons - 1;
    [animationList showInView:mainView];
    [animationList release];
	
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(buttonIndex == actionSheet.cancelButtonIndex)
		return;
	NSString *animationLabel = [actionSheet buttonTitleAtIndex:(buttonIndex)];
	Animation *selectedAnimation = nil;
	for(Animation * animation in [mainView.nounours.curTheme.animations allValues])
	{
		if([animationLabel isEqualToString:animation.label])
		{
			selectedAnimation = animation;
			break;
		}
	}
	if(selectedAnimation != nil)
		[mainView.nounours doAnimation:selectedAnimation.uid];
	
}
@end
