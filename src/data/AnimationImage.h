//
//  AnimationImage.h
//  Nounours
//
//  Created by Carmen Alvarez on 11/20/10.
//  Copyright 2010-2011 Carmen Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AnimationImage : NSObject {
@private NSString* imageId;
@private float duration;
}

-(AnimationImage*) initAnimationImage:(NSString*)pimageId withDuration:(float) pduration;
																		
@property(retain,readonly) NSString* imageId;
@property(readonly) float duration;
@end
