//
//  NounoursViewController.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../src/ui/MainView.h"
#import "Nounours.h"
@interface NounoursViewController : UIViewController {
@private MainView* mainView; 
@private Nounours *nounours;
@private UIActivityIndicatorView *activityView;
}
-(void) doLoad:(id) sender;
@property(retain,readonly) Nounours *nounours;
@end

