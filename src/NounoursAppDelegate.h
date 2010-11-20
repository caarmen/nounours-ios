//
//  NounoursAppDelegate.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NounoursViewController;

@interface NounoursAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    NounoursViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet NounoursViewController *viewController;

@end

