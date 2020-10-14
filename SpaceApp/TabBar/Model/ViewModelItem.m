//
//  ViewModelItem.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/26/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "ViewModelItem.h"
#import "NetworkManager.h"

@implementation ViewModelItem

- (id)initWithID:(NSString *)ID {
    self = [super init];
    if (self) {
        self.ID = ID;
      //  [self parseDataForArticle];
    }
    return self;
}

- (void)parseDataForArticle:(NSDictionary *)dict completion:(void (^)(ViewModelItem *dict))completion  {
     //   NetworkManager *networkmanager = [NetworkManager new];
//    [networkmanager requestArticleWithID:self.ID andCompliteon:^(NSDictionary * dict) {
        self.name = [dict objectForKey:@"name"];
        self.abstract = [dict objectForKey:@"abstract"];
        self.publication = [dict objectForKey:@"publication"];
        self.thumbnail = [dict objectForKey:@"thumbnail"];
        self.url = [dict objectForKey:@"url"];

//    dispatch_async(dispatch_get_main_queue(), ^{
//
//    [networkmanager requestImageWithURL:self.thumbnail andCompliteon:^(UIImage * image) {
//      //  self.image = image;
//        NSLog(@"%@", image);
//        }];
//    });
        completion(self);
//        NSLog(@"%@", dict);
//    }];
}

@end
