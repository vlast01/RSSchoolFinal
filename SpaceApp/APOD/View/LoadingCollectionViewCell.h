//
//  LoadingCollectionViewCell.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/5/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingCollectionViewCell : UICollectionViewCell

@property (nonatomic) UIActivityIndicatorView *spinner;
- (void)setupCell;

@end

NS_ASSUME_NONNULL_END
