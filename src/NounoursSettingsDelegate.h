//
//  NounoursSettingsDelegate.h
//  Nounours
//
//  Created by Carmen Alvarez on 6/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IASKAppSettingsViewController.h"
#import "Nounours.h"


@interface NounoursSettingsDelegate : NSObject <IASKSettingsDelegate> {
@private IASKAppSettingsViewController* settingsViewController;
@private Nounours* nounours;
}
-(NounoursSettingsDelegate*) initNounoursSettingsDelegate: (IASKAppSettingsViewController*) pcontroller withNounours:(Nounours*) pnounours;

@end
