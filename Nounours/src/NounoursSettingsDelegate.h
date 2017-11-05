//
//  NounoursSettingsDelegate.h
//  Nounours
//
//  Created by Carmen Alvarez on 6/18/11.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InAppSettingsKit/IASKAppSettingsViewController.h"
#import "Nounours.h"


@interface NounoursSettingsDelegate : NSObject <IASKSettingsDelegate> {
@private IASKAppSettingsViewController* settingsViewController;
@private Nounours* nounours;
}
-(NounoursSettingsDelegate*) initNounoursSettingsDelegate: (IASKAppSettingsViewController*) pcontroller withNounours:(Nounours*) pnounours;

@end
