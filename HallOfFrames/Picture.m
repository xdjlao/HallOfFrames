//
//  Picture.m
//  HallOfFrames
//
//  Created by Jerry on 1/20/16.
//  Copyright © 2016 Jerry Lao. All rights reserved.
//

#import "Picture.h"

@implementation Picture

-(instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    
    self.image = image;
    self.red = 0;
    self.green = 0;
    self.blue = 0;
    
    return self;
}

@end
