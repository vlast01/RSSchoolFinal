//
//  NewsCell.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/26/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "NewsCell.h"
#import "NewsViewControllerPresenter.h"
#import "NetworkManager.h"

@implementation NewsCell

- (void)setupCell {
    self.backgroundColor = [UIColor blackColor];
    [self setupImageView];
    [self setupLabel];
    [self activateConstraints];
}

- (void)setupImageView {
    self.customImageView = [UIImageView new];
    self.customImageView.clipsToBounds = YES;
    self.customImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.customImageView.image = [UIImage imageNamed:@"placeholder_dark"];
    self.customImageView.layer.cornerRadius = 10;
    [self addSubview:self.customImageView];
}

- (void)setupLabel {
    self.label = [UILabel new];
    [self addSubview:self.label];
    self.label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    self.label.text = @"Loading...";
    self.label.numberOfLines = 0;
    self.label.textColor = [UIColor whiteColor];
}

- (void)activateConstraints {
    self.customImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.customImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20],
        [self.customImageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:20],
        [self.customImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-20],
        [self.customImageView.widthAnchor constraintEqualToConstant:160],
        [self.label.leadingAnchor constraintEqualToAnchor:self.customImageView.trailingAnchor constant:20],
        [self.label.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-20],
        [self.label.topAnchor constraintEqualToAnchor:self.topAnchor constant:20],
        [self.label.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-20],
    ]];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.label.text = @"";
    self.customImageView.image = [UIImage imageNamed:@"placeholder_dark"];
}

@end
