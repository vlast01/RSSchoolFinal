//
//  IssCell.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/31/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdditionalIssViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface IssCell : UITableViewCell

@property (nonatomic) UILabel *dateLabel;
@property (nonatomic) UILabel *durationLabel;
@property (nonatomic) UIButton *reminderButton;
@property (nonatomic) BOOL isGrantedNotificationAccess;
@property (nonatomic) AdditionalIssViewController *parentVC;
- (void)setupCell;

@end

NS_ASSUME_NONNULL_END
