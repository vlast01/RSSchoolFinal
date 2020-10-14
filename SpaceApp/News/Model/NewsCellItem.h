//
//  NewsCellItem.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/4/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsCellItem : NSObject

@property (nonatomic) NSString* ID;
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* publication;
@property (nonatomic) NSString* abstract;
@property (nonatomic) NSString* thumbnail;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *liked;

@end

NS_ASSUME_NONNULL_END
