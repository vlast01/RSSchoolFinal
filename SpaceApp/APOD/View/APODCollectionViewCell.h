//
//  APODCollectionViewCell.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/5/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APODItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface APODCollectionViewCell : UICollectionViewCell

@property (nonatomic) UIImageView *customImageView;
@property (nonatomic) APODItem *item;
- (void)setupCell;

@end

NS_ASSUME_NONNULL_END
