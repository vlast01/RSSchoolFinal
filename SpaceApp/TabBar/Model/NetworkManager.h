//
//  NetworkManager.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/26/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

- (NSMutableURLRequest *) makeNewsArrayGetRequest;
- (NSDictionary *) makeEmptyHeader;
- (NSMutableURLRequest *) configureNewsArrayGetRequest;
- (void)requestNewsWithCompliteon: (void(^)(NSArray<NSDictionary *> *))completion;
- (NSMutableURLRequest *)makeNewsArrayGetRequest:(NSString *)ID;
- (void)requestArticleWithID:(NSString *)ID andCompliteon:(void (^)(NSDictionary *))completion;
- (void)requestImageWithURL:(NSString *)url andCompliteon:(void (^)(UIImage* image))completion;
- (void)requestPassesWithLat:(NSString *)lat andLon:(NSString *)lon andCompliteon:(void (^)(NSArray<NSDictionary *> *))completion;
- (void)requestIssPositionWithCompliteon: (void(^)(NSDictionary *))completion;
- (void)requestImageWithDateURL:(NSString *)url andCompliteon:(void (^)(UIImage* image))completion;
- (void)requestImageURLWithDateURL:(NSString *)url andCompliteon:(void (^)(NSString* url))completion;

@end

NS_ASSUME_NONNULL_END
