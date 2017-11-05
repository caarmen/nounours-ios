//
//  AboutView.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/28/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import "AboutView.h"


@implementation AboutView
@synthesize appLabel;
@synthesize authorLabel;
@synthesize emailLabel;
@synthesize creditsLabel;
@synthesize skaLabel;
@synthesize inAppSettingsLabel;
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
	if(gradientImage == nil)
	{
		[self makeGradientImage];
//		[dismissButton setBackgroundImage:gradientImage forState:UIControlStateNormal];
	}
	[self setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
	appLabel.text=NSLocalizedString(@"abouttextversion",@"");
	authorLabel.text=NSLocalizedString(@"abouttextauthor",@"");
	emailLabel.text=NSLocalizedString(@"abouttextemail",@"");
	creditsLabel.text=NSLocalizedString(@"abouttextcredits",@"");
	skaLabel.text=NSLocalizedString(@"abouttextmacarenours",@"");
	inAppSettingsLabel.text=NSLocalizedString(@"abouttextinappsettings",@"");
	//dismissButton.titleLabel.text=@"Ok";
}

- (void) makeGradientImage {
    // Open image context.
    UIGraphicsBeginImageContext(CGSizeMake(1, 2));
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    // Create gradient.
    CGColorRef colorRefs[2] = {
        [[UIColor grayColor] CGColor], 
        [[UIColor lightGrayColor] CGColor]
    };
    CFArrayRef colors = CFArrayCreate(NULL, (const void **)colorRefs, 2, NULL);
    CGGradientRef gradient = CGGradientCreateWithColors(NULL, colors, NULL);
    
    // Create image.
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, 1), 0);
    gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Clean up.
    CFRelease(colors);
    CGGradientRelease(gradient);
    UIGraphicsEndImageContext();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/



@end
