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

-(UIAlertController*)createAnimationList:(Nounours*) nounours{
	UIAlertController * animationList = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"actions",@"") message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	[animationList addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"random",@"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		NSArray *animationLabels = [nounours.curTheme.animations allKeys];
		int random = arc4random()%[animationLabels count];
		NSString *randomAnimationLabel = [animationLabels objectAtIndex:random];
		Animation *animation = nounours.curTheme.animations[randomAnimationLabel];
		[nounours doAnimation:animation.uid];
	}]];
	for(Animation * animation in [nounours.curTheme.animations allValues]) {
		if(animation.visible) {
			[animationList addAction:[UIAlertAction actionWithTitle:animation.label style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
				[nounours doAnimation:animation.uid];
			}]];
		}
	}
	[animationList addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", @"") style:UIAlertActionStyleCancel handler:nil]];
	return animationList;
}

@end
