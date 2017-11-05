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

#import <UIKit/UIKit.h>


@interface AboutView : UIView {
	UILabel *appLabel __unsafe_unretained;
	UILabel *authorLabel __unsafe_unretained;
	UILabel *emailLabel __unsafe_unretained;
	UILabel *creditsLabel __unsafe_unretained;
	UILabel *skaLabel __unsafe_unretained;
	UILabel *inAppSettingsLabel __unsafe_unretained;
	UIBarButtonItem *dismissButton __unsafe_unretained;
@private UIView *parentView;
@private UIImage *gradientImage;
}
-(IBAction) onDismiss:(id) sender;
-(void) setup;
-(void) makeGradientImage;
@property(assign) IBOutlet UILabel *appLabel;
@property(assign) IBOutlet UILabel *authorLabel;
@property(assign) IBOutlet UILabel *emailLabel;
@property(assign) IBOutlet UILabel *creditsLabel;
@property(assign) IBOutlet UILabel *skaLabel;
@property(assign) IBOutlet UILabel *inAppSettingsLabel;
@property(assign) IBOutlet UIBarButtonItem *dismissButton;
@property(readwrite,retain) UIView *parentView;
@end
