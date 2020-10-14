//
//  StreamViewControllerPresenter.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/2/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IssPositionModelItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface StreamViewControllerPresenter : NSObject

- (void)requestIssPositionWithCompliteon: (void(^)(IssPositionModelItem*))completion;

@end

NS_ASSUME_NONNULL_END
