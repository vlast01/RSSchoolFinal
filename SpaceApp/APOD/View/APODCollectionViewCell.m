//
//  APODCollectionViewCell.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/5/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "APODCollectionViewCell.h"

@implementation APODCollectionViewCell

- (void)setupCell {
    [self setupCustomImageView];
    [self setupConstraints];
}

- (void)setupCustomImageView {
    self.customImageView = [UIImageView new];
    self.customImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.customImageView.clipsToBounds = YES;
    self.customImageView.image = [UIImage imageNamed:@"placeholder_dark"];
    [self addSubview:self.customImageView];
}

- (void)setupConstraints {
    self.customImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.customImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.customImageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.customImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.customImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
    ]];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.customImageView.image = [UIImage imageNamed:@"placeholder_dark"];
}


@end
