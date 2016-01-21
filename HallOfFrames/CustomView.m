//
//  CustomView.m
//  HallOfFrames
//
//  Created by Jerry on 1/20/16.
//  Copyright © 2016 Jerry Lao. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (IBAction)onButtonPressed:(UIButton *)sender {
    [self.delegate customView:self didTapButton:sender];
}

@end
