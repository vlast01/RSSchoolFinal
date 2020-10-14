//
//  NewsCell.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/26/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsCell : UITableViewCell

@property (nonatomic) UIImageView *customImageView;
@property (nonatomic) UILabel *label;
@property (nonatomic) NSString *ID;
@property (nonatomic) int indexPathRow;
- (void)setupCell;

@end

NS_ASSUME_NONNULL_END
