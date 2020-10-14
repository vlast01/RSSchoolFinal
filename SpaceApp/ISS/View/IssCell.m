//
//  IssCell.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/31/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "IssCell.h"
#import <UserNotifications/UserNotifications.h>
#import "IssViewControllerPresenter.h"


@implementation IssCell


- (void)setupCell {
    self.backgroundColor = [UIColor blackColor];
    [self setupDateLabel];
    [self setupDurationLabel];
    [self setupLayout];
    [self setupButton];
}

- (void)setupDateLabel {
    self.dateLabel = [UILabel new];
    self.dateLabel.font = [UIFont systemFontOfSize:25 weight:UIFontWeightSemibold];
    self.dateLabel.text = @"Text";
    self.dateLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.dateLabel];
}

- (void)setupDurationLabel {
    self.durationLabel = [UILabel new];
    self.durationLabel.font = [UIFont systemFontOfSize:23 weight:UIFontWeightSemibold];
    self.durationLabel.text = @"Text";
    self.durationLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.durationLabel];
}

- (void)setupButton {
    self.reminderButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 90, 100, 40)];
    self.reminderButton.backgroundColor = [UIColor systemBlueColor];
    self.reminderButton.layer.cornerRadius = 10;
    [self.reminderButton setTitle:@"Remind me" forState:UIControlStateNormal];
    self.reminderButton.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    self.reminderButton.titleLabel.textColor = [UIColor whiteColor];
    [self.reminderButton addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.reminderButton];
}

- (void)setupLayout {
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.durationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.reminderButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.dateLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10],
        [self.dateLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10],
        [self.dateLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10],
        [self.durationLabel.topAnchor constraintEqualToAnchor:self.dateLabel.bottomAnchor constant:10],
        [self.durationLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10],
        [self.durationLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10],
    ]];
}

- (void)buttonTapped {
    IssViewControllerPresenter *issPresenter = [IssViewControllerPresenter new];
    issPresenter.isGrantedNotificationAccess = self.isGrantedNotificationAccess;
    [issPresenter configureNotification:self.dateLabel.text];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"OK"
                                                                   message:@"Notification will come in 5 minutes before the flight"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self.parentVC presentViewController:alert animated:YES completion:nil];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.dateLabel.text = @"";
    self.durationLabel.text = @"";
}

@end
