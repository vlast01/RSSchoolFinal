//
//  NewsViewControllerPresenter.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/26/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NewsViewController.h"
#import "NewsCellItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsViewControllerPresenter : NSObject

@property (nonatomic) NSMutableArray *idArray;
- (void)requestNewsWithCompletion: (void(^)(NSArray<NSDictionary *> *))completion;
- (void)requestArticleWithID:(NSString *)ID andCompliteon:(void (^)(NewsCellItem *))completion;
- (void)getImageForURL:(NSString *)url andCompletion:(void (^)(UIImage *))completion;

@end

NS_ASSUME_NONNULL_END
