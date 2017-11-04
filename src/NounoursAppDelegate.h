//
//  NounoursAppDelegate.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/13/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NounoursViewController.h"
@interface NounoursAppDelegate : NSObject <UIApplicationDelegate> {
@private NounoursViewController *viewController;
}
@property (strong, nonatomic) UIWindow *window;
@end

