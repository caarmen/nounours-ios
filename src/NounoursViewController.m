//
//  NounoursViewController.m
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NounoursViewController.h"

#import "Nounours.h";
@implementation NounoursViewController
@synthesize nounours;
@synthesize appSettingsViewController;


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
	mainView = [[MainView alloc]initWithFrame:[UIScreen mainScreen].bounds];
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
	[activityView stopAnimating];
	[self.view setAlpha:1.0];
	[activityView removeFromSuperview];
	[activityView release];
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


- (void)dealloc {
    [super dealloc];
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
	UINavigationController *aNavController = [[UINavigationController alloc] initWithRootViewController:self.appSettingsViewController];
	
	self.appSettingsViewController.showDoneButton = YES;
	[self presentModalViewController:aNavController animated:YES];
	[aNavController release];
}


@end
