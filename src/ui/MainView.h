//
//  MainView.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainView : UIImageView {
@private UIImage * curImage;
@private NSMutableDictionary *imageCache;
}
-(void) setImageFromFilename:(NSString*) pfilename;
-(CGSize) getImageSize;

@property(retain,readwrite) UIImage* myImage;
@end
