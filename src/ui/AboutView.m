//
//  AboutView.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AboutView.h"


@implementation AboutView
@synthesize aboutLabel;
@synthesize appLabel;
@synthesize authorLabel;
@synthesize emailLabel;
@synthesize creditsLabel;
@synthesize skaLabel;
@synthesize dismissButton;
@synthesize parentView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}
-(IBAction) onDismiss:(id) sender{
	[parentView sendSubviewToBack:self];
	[self removeFromSuperview];
}
-(void) setup{
	aboutLabel.text=@"About";
	appLabel.text=@"Nounours v 1.0.0 for iPhone";
	authorLabel.text=@"By Carmen Alvarez";
	emailLabel.text=@"c@rmen.ca";
	creditsLabel.text=@"Credits:";
	skaLabel.text=@"B-Roll (Macarenous action): Kevin MacLeod (incompetech.com)";
	dismissButton.titleLabel.text=@"Ok";
	
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
