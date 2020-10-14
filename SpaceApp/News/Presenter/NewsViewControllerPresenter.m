//
//  NewsViewControllerPresenter.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/26/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "NewsViewControllerPresenter.h"
#import "NetworkManager.h"
#import "NewsCellItem.h"

@implementation NewsViewControllerPresenter

- (void)requestNewsWithCompletion: (void(^)(NSArray<NSDictionary *> *))completion {
    
    if (self.idArray == nil) {
        self.idArray = [NSMutableArray new];
    }
    
    NetworkManager *networkManager = [NetworkManager new];
    [networkManager requestNewsWithCompliteon:^(NSArray<NSDictionary *> * itemList) {
        for (NSDictionary *item in itemList) {
            NSString *ID = [self parseNewsID:item];
            [self.idArray addObject:ID];
        }
        completion(self.idArray);
    }];
}

- (NSString *)parseNewsID:(NSDictionary *)dictionary {
    NSString *ID = [dictionary objectForKey:@"url"];
    return [ID substringFromIndex:ID.length-7];
}

- (void)requestArticleWithID:(NSString *)ID andCompliteon:(void (^)(NewsCellItem *))completion {
    NetworkManager *networkManager = [NetworkManager new];
    [networkManager requestArticleWithID:ID andCompliteon:^(NSDictionary * dict) {
        [self parseDataForArticle:dict completion:^(NewsCellItem * item) {
            completion(item);
        }];
    }];
}

- (void)parseDataForArticle:(NSDictionary *)dict completion:(void (^)(NewsCellItem *dict))completion  {
    NewsCellItem *item = [NewsCellItem new];
    item.name = [dict objectForKey:@"name"];
    item.abstract = [dict objectForKey:@"abstract"];
    item.publication = [dict objectForKey:@"publication"];
    item.thumbnail = [dict objectForKey:@"thumbnail_retina"];
    completion(item);
}

- (void)getImageForURL:(NSString *)url andCompletion:(void (^)(UIImage * _Nonnull))completion {
    NetworkManager *networkManager = [NetworkManager new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [networkManager requestImageWithURL:url andCompliteon:^(UIImage * image) {
            completion(image);
        }];
    });
}



@end
