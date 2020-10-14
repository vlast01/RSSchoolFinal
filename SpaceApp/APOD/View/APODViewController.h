//
//  APODViewController.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/25/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface APODViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic) NSCache *cache;

@end

NS_ASSUME_NONNULL_END
