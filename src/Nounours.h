//
//  Nounours.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ui/MainView.h";
#import "data/Image.h";
#import "data/Feature.h";
#import "AnimationHandler.h"
#import "data/FlingAnimation.h"

@interface Nounours : NSObject {
@private MainView* mainView;
@private Image *curImage;
@private Image *defaultImage;
@private Feature *curFeature;
@private NSMutableDictionary *images;
@private NSMutableDictionary *animations;
@private AnimationHandler *animationHandler;
@private NSMutableArray *flingAnimations;
@private CGPoint lastLocation;
}
-(Nounours*) initNounours:(MainView*) pmainView;
-(void) displayImage:(Image*)pimage;
-(void) onPress:(CGFloat)px withY:(CGFloat)py;
-(void) onRelease;
-(void) onMove:(CGFloat)px withY:(CGFloat)py;
-(void) onFling:(UIPanGestureRecognizer*) pgestureRecognizer;
-(void) setImage:(Image*) pimage;
-(void) setImageWithImageId:(NSString*) pimageId;
-(void) debug:(NSObject*) po;
-(CGFloat) getDeviceWidth;
-(CGFloat) getDeviceHeight;
-(void) resizeView;
@property(retain,readwrite) Image* defaultImage;

@end
