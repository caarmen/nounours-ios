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
    [super viewDidLoad];
	
 mainView = [[MainView alloc]initWithFrame:[UIScreen mainScreen].bounds];
 self.view = mainView;
	nounours = [[Nounours alloc] initNounours:mainView];
	//	[nounours displayImage:image];
	//		[NSThread sleepForTimeInterval:1]; 
	/*	[mainView stopAnimating];
	 mainView.animationImages = uiImages;
	 mainView.animationDuration = 0.3* [uiImages count];
	 mainView.animationRepeatCount = 1;
	 [mainView startAnimating];
	 */	
	
	
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
}


- (void)dealloc {
    [super dealloc];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	if([touches count] !=1)
		return;
	UITouch *touch = [[touches objectEnumerator]nextObject];
	CGPoint point = [touch locationInView:mainView];
	[nounours onPress:point.x withY:point.y];
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

@end