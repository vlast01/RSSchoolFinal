//
//  APODViewControllerPresenter.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/5/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NetworkManager.h"
#import "APODItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface APODViewControllerPresenter : NSObject

@property (nonatomic) NetworkManager *networkManager;
- (void)getImageForIndexPath:(long)index andCompletion:(void (^)(APODItem *))completion;
- (NSNumber *)increaseNumberOfRows:(NSNumber*)number;
- (NSString *) configureURL:(long)index;

@end

NS_ASSUME_NONNULL_END
