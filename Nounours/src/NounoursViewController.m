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

#import "NounoursViewController.h"

#import "Nounours.h"
#import "ui/AboutView.h"
@implementation NounoursViewController
@synthesize nounours;
@synthesize appSettingsViewController;
@synthesize aboutViewController;
@synthesize aboutView;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}



// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {

}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"viewDidLoad begin");
    [super viewDidLoad];
	CGRect screenBounds = [UIScreen mainScreen].bounds;
	CGFloat activityViewSize = 32;
	activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(screenBounds.size.width/2 - activityViewSize/2, screenBounds.size.height/2 - activityViewSize, activityViewSize,activityViewSize)];
	mainView = [[MainView alloc]initMainView:[UIScreen mainScreen].bounds withController:self];
	self.view =mainView;
	[self.view setAlpha:0.5];
	[self.view addSubview:activityView];
	[self.view bringSubviewToFront:activityView];
	[activityView startAnimating];
	[self performSelector:@selector(doLoad:) withObject:self afterDelay:0];
	NSLog(@"viewDidLoad end");

}


-(void) doLoad:(id) sender{
	nounours = [[Nounours alloc] initNounours:mainView];
	if (!appSettingsViewController) {
		appSettingsViewController = [[IASKAppSettingsViewController alloc] initWithNibName:@"IASKAppSettingsView" bundle:nil];
		nounoursSettingsDelegate = [[NounoursSettingsDelegate alloc] initNounoursSettingsDelegate:appSettingsViewController withNounours:nounours];
									appSettingsViewController.delegate = nounoursSettingsDelegate;
	}
	if(!aboutViewController)
	{
		aboutViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
		aboutView = [[[NSBundle mainBundle] loadNibNamed:@"AboutView" owner:self options:nil] objectAtIndex:0];
		[aboutView setup];
		aboutViewController.view = aboutView;
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                                    target:aboutViewController 
                                                                                    action:@selector(dismissModalViewControllerAnimated:)];
        aboutViewController.navigationItem.rightBarButtonItem = buttonItem;
		aboutViewController.navigationItem.title = NSLocalizedString(@"about",@"");
		aboutViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	}
	[activityView stopAnimating];
	[self.view setAlpha:1.0];
	[activityView removeFromSuperview];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	NSLog(@"viewDidUnload");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[super touchesBegan:touches withEvent:event];
	
	if([touches count] !=1)
		return;
	
	UITouch *touch = [[touches objectEnumerator]nextObject];
	CGPoint point = [touch locationInView:mainView];
	if(touch.view == mainView)
	{
		[nounours onPress:point.x withY:point.y];
	}
	else if(touch.view == mainView.menuIconView)
	{
		[mainView showMenu:point.x withY:point.y];
	}
	else if(touch.view == mainView.settingsIconView)
	{
		[self showSettings];
	}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	[nounours onRelease];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	if([touches count] !=1)
		return;
	UITouch *touch = [[touches objectEnumerator]nextObject];
	CGPoint point = [touch locationInView:mainView];
	[nounours onMove:point.x withY:point.y];
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
	if(motion == UIEventSubtypeMotionShake){
		[nounours onShake];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	if(nounours != nil)
	{
		[mainView resizeView];
	}
}
- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"viewDidAppear");
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
	if(nounours != nil)
		[nounours loadPreferences];
}

- (void)viewDidDisappear:(BOOL)animated {
	NSLog(@"viewDidDisappear");
    [self resignFirstResponder];
    [super viewDidDisappear:animated];
	if(nounours != nil)
		[nounours savePreferences];
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}

-(void) showSettings
{
	[nounours stopAnimation];
	UINavigationController *aNavController = [[UINavigationController alloc] initWithRootViewController:self.appSettingsViewController];
	[self.appSettingsViewController setShowCreditsFooter:NO];
	self.appSettingsViewController.showDoneButton = YES;
	[self presentModalViewController:aNavController animated:YES];
}
-(void) showAbout
{

	UINavigationController *aNavController = [[UINavigationController alloc] initWithRootViewController:self.aboutViewController];
	[self presentModalViewController:aNavController animated:YES];
}

@end
