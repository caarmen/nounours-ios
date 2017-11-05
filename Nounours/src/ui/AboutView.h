//
//  AboutView.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/28/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
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
