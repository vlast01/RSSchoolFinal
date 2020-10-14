//
//  ModalViewController.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/6/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIButton *cancelButton;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    [self setupButton];
    [self setupImageView];
    [self setupConstraints];
}

- (void)setupButton {
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.cancelButton.frame = CGRectMake(0, 0, 40, 40);
    self.cancelButton.layer.cornerRadius = 10;
    [self.cancelButton setTitle:@"X" forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:normal];
    self.cancelButton.backgroundColor = [UIColor darkGrayColor];
    [self.cancelButton addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
}

- (void)setupImageView {
    self.imageView = [UIImageView new];
    self.imageView.image = [self setupImage:self.imageView.image];
    [self.view addSubview:self.imageView];
    self.imageView.contentMode =UIViewContentModeScaleAspectFill;
}

- (void)setupConstraints {
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.cancelButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-30],
        [self.cancelButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:10],
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
    ]];
}

- (UIImage *)setupImage:(UIImage*)image {
    UIImage *newImage = [UIImage new];
    newImage = self.item.image;
    if (self.view.frame.size.width>self.view.frame.size.height) {
        if (self.item.image.size.width >= self.item.image.size.height) {
            
            newImage = [self resizeImage:newImage newWidth:self.view.frame.size.width*0.6];
        }
        else {
            newImage = [self resizeImage:newImage newWidth:self.view.frame.size.height-200];
        }
        
    }
    
    else {
        
        if (self.item.image.size.width >= self.item.image.size.height) {
            
            newImage = [self resizeImage:self.item.image newWidth:self.view.frame.size.width-50];
        }
        else newImage = [self resizeImage:self.item.image newWidth:self.view.frame.size.width*0.7];
    }
    return newImage;
}

- (void)tapped {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image newWidth:(CGFloat)newWidth {
    
    double scale = newWidth / image.size.width;
    double newHeight = image.size.height * scale;
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [image drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    UIImage *newImage = [UIImage new];
    newImage = self.item.image;
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        
        if (self.item.image.size.width >= self.item.image.size.height) {
            newImage = [self resizeImage:newImage newWidth:self.view.frame.size.height*0.6];
        }
        else {
            newImage = [self resizeImage:newImage newWidth:self.view.frame.size.width-200];
        }
    }
    else {
        if (self.item.image.size.width >= self.item.image.size.height) {
            newImage = [self resizeImage:self.item.image newWidth:self.view.frame.size.height-50];
        }
        else {
            newImage = [self resizeImage:self.item.image newWidth:self.view.frame.size.height*0.7];
        }
    }
    self.imageView.image = newImage;
}


@end
