//
//  Model.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/27/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject

- (NSString *)parseNewsID:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END
