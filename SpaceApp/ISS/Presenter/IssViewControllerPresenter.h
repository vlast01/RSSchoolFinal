//
//  IssViewControllerPresenter.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/31/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IssPassViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IssViewControllerPresenter : NSObject

@property (nonatomic) BOOL isGrantedNotificationAccess;
- (void)requestPassingWithLat:(NSString *)lat andLon:(NSString *)lon Compliteon: (void(^)(NSArray<IssPassViewModel *> *))completion;
- (void)configureNotification:(NSString *)dateLabel;
- (int)calculateTiteInterval:(NSString *)dateLabel;


@end

NS_ASSUME_NONNULL_END
