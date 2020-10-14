//
//  LoadingCollectionViewCell.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/5/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "LoadingCollectionViewCell.h"

@implementation LoadingCollectionViewCell

- (void)setupCell {
    [self setupActivityIndicator];
}

- (void)setupActivityIndicator {
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    self.spinner.color = [UIColor whiteColor];
    self.spinner.frame = CGRectMake(0, 0, 50, 50);
    [self addSubview:self.spinner];
    self.spinner.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.spinner.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.spinner.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
    ]];
    [self.spinner startAnimating];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.spinner stopAnimating];
}
@end
