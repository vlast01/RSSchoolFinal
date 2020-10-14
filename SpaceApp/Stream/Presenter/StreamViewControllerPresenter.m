//
//  StreamViewControllerPresenter.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/2/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "StreamViewControllerPresenter.h"
#import "NetworkManager.h"
#import "IssPositionModelItem.h"

@implementation StreamViewControllerPresenter

- (void)requestIssPositionWithCompliteon:(void (^)(IssPositionModelItem * _Nonnull))completion {
    NetworkManager *networkManager = [NetworkManager new];
    [networkManager requestIssPositionWithCompliteon:^(NSDictionary * dict) {
        
        [self parseDataForIssPosition:dict completion:^(IssPositionModelItem * item) {
            completion(item);
        }];
    }];
}

- (void)parseDataForIssPosition:(NSDictionary *)dict completion:(void (^)(IssPositionModelItem * _Nonnull))completion {
    IssPositionModelItem *modelItem = [IssPositionModelItem new];
    NSDictionary *positionDict = [dict valueForKey:@"iss_position"];
    modelItem.latitude = [[positionDict valueForKey:@"latitude"] floatValue];
    modelItem.longitude = [[positionDict valueForKey:@"longitude"] floatValue];
    completion(modelItem);
}

@end
