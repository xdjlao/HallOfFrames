//
//  CustomView.h
//  HallOfFrames
//
//  Created by Jerry on 1/20/16.
//  Copyright © 2016 Jerry Lao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomViewDelegate <NSObject>

@required

@optional

- (void) customView:(id)view didTapButton:(UIButton *)button;

@end

@interface CustomView : UIView

@property (nonatomic, assign)id <CustomViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@end
