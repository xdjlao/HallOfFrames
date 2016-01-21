//
//  ViewController.m
//  HallOfFrames
//
//  Created by Jerry on 1/20/16.
//  Copyright © 2016 Jerry Lao. All rights reserved.
//

#import "ViewController.h"
#import "Picture.h"
#import "PictureCollectionViewCell.h"
#import "CustomView.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, CustomViewDelegate>

@property Picture *currentPicture;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Picture *pic1 = [[Picture alloc] initWithImage:[UIImage imageNamed:@"bltImage"]];
    Picture *pic2 = [[Picture alloc] initWithImage:[UIImage imageNamed:@"saladImage"]];
    Picture *pic3 = [[Picture alloc] initWithImage:[UIImage imageNamed:@"pbjImage"]];
    Picture *pic4 = [[Picture alloc] initWithImage:[UIImage imageNamed:@"milkImage"]];
    Picture *pic5 = [[Picture alloc] initWithImage:[UIImage imageNamed:@"sodaImage"]];
    
    self.pictures = [NSMutableArray arrayWithObjects:pic1, pic2, pic3, pic4, pic5, nil];

}

#pragma mark - Collection Delegate methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pictures.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ViewCell" forIndexPath:indexPath];
    Picture *currentPicture = [self.pictures objectAtIndex:indexPath.row];
    cell.imageView.image = (UIImage *)[currentPicture image];
    cell.backgroundColor = [UIColor colorWithRed:currentPicture.red/255 green:currentPicture.green/255 blue:currentPicture.blue/255 alpha:1.0];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    Picture *currentPic = [self.pictures objectAtIndex:indexPath.row];
    self.currentPicture = currentPic;
    CustomView *hiddenView = [[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil] objectAtIndex:0];
    hiddenView.delegate = self;
    
    // Setting the constraints
    hiddenView.center = [self.view convertPoint:self.view.center fromView:self.view.superview];
    hiddenView.frame = self.view.frame;
    
    // Slider
    Picture *currentPicture = [self.pictures objectAtIndex:indexPath.row];
    hiddenView.redSlider.minimumValue = 0;
    hiddenView.redSlider.maximumValue = 255;
    hiddenView.redSlider.value = currentPicture.red;
    
    
    hiddenView.greenSlider.minimumValue = 0;
    hiddenView.greenSlider.maximumValue = 255;
    hiddenView.greenSlider.value = currentPicture.green;
    
    hiddenView.blueSlider.minimumValue = 0;
    hiddenView.blueSlider.maximumValue = 255;
    hiddenView.blueSlider.value = currentPicture.blue;

    [self.view addSubview:hiddenView];
}

#pragma mark - Custom Delegates

- (void)customView:(id)view didTapButton:(UIButton *)button {
    [view removeFromSuperview];
    
    if ([button.titleLabel.text isEqualToString:@"Red"]) {
        self.currentPicture.red = 255;
        self.currentPicture.green = 0;
        self.currentPicture.blue = 0;
    } else if ([button.titleLabel.text isEqualToString:@"Green"]) {
        self.currentPicture.red = 0;
        self.currentPicture.green = 255;
        self.currentPicture.blue = 0;
    } else if ([button.titleLabel.text isEqualToString:@"Blue"]) {
        self.currentPicture.red = 0;
        self.currentPicture.green = 0;
        self.currentPicture.blue = 255;
    }
    
    [self.collectionView reloadData];
}

- (void)testSlider:(id)view didSlide:(UISlider *)slider {
    self.title = [NSString stringWithFormat:@"Value is: %f", slider.value];
}

- (void)sliderChange:(id)view didSlide:(UISlider *)slider {
    
        if (slider.tag == 1) {
            self.currentPicture.red = slider.value;
        } else if (slider.tag == 2) {
            self.currentPicture.green = slider.value;
        } else if (slider.tag == 3) {
            self.currentPicture.blue = slider.value;
        }
    
        [self.collectionView reloadData];
}

@end
