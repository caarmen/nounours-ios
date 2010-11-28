//
//  AboutView.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutView : UIView {
	UILabel *aboutLabel;
	UILabel *appLabel;
	UILabel *authorLabel;
	UILabel *emailLabel;
	UILabel *creditsLabel;
	UILabel *skaLabel;
	UIButton *dismissButton;
@private UIView *parentView;
}
-(IBAction) onDismiss:(id) sender;
-(void) setup;
@property(assign) IBOutlet UILabel *aboutLabel;
@property(assign) IBOutlet UILabel *appLabel;
@property(assign) IBOutlet UILabel *authorLabel;
@property(assign) IBOutlet UILabel *emailLabel;
@property(assign) IBOutlet UILabel *creditsLabel;
@property(assign) IBOutlet UILabel *skaLabel;
@property(assign) IBOutlet UIButton *dismissButton;
@property(readwrite,retain) UIView *parentView;
@end
