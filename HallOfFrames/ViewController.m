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

@property NSIndexPath *cellRow;
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
    
    self.cellRow = indexPath;
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
    
    [hiddenView.redSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [hiddenView.greenSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [hiddenView.blueSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:hiddenView];
}

#pragma mark - Custom Delegates

- (void)customView:(id)view didTapButton:(UIButton *)button {
    [view removeFromSuperview];
    
    Picture *currentPicture = [self.pictures objectAtIndex:self.cellRow.row];
    
    if ([button.titleLabel.text isEqualToString:@"Red"]) {
        currentPicture.red = 255;
        currentPicture.green = 0;
        currentPicture.blue = 0;
    } else if ([button.titleLabel.text isEqualToString:@"Green"]) {
        currentPicture.red = 0;
        currentPicture.green = 255;
        currentPicture.blue = 0;
    } else if ([button.titleLabel.text isEqualToString:@"Blue"]) {
        currentPicture.red = 0;
        currentPicture.green = 0;
        currentPicture.blue = 255;
    }
    
    [self.collectionView reloadData];
}

#pragma mark - methods

- (void)valueChange:(UISlider*)sender {
    Picture *currentPicture = [self.pictures objectAtIndex:self.cellRow.row];
    
    if (sender.tag == 1) {
        currentPicture.red = sender.value;
        NSLog(@"%f", sender.value);
    } else if (sender.tag == 2) {
        currentPicture.green = sender.value;
    } else if (sender.tag == 3) {
        currentPicture.blue = sender.value;
    }
    
    [self.collectionView reloadData];
}

@end
