//
//  Picture.h
//  HallOfFrames
//
//  Created by Jerry on 1/20/16.
//  Copyright © 2016 Jerry Lao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Picture : NSObject

@property UIImage *image;
@property float red;
@property float green;
@property float blue;

-(instancetype)initWithImage:(UIImage *)image;

@end
