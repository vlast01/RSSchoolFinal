//
//  APODViewControllerPresenter.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/5/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "APODViewControllerPresenter.h"
#import "NetworkManager.h"
#import "APODItem.h"

@implementation APODViewControllerPresenter

- (void)getImageForIndexPath:(long)index andCompletion:(void (^)(APODItem * _Nonnull))completion {
    if (!self.networkManager) {
        self.networkManager = [NetworkManager new];
    }
    
    [self.networkManager requestImageURLWithDateURL:[self configureURL:index] andCompliteon:^(NSString * url) {
        if ([url containsString:@"youtube"]) {
            NSString *videoId = [url substringWithRange:NSMakeRange(30, 11)];
            NSMutableString *newURL = [NSMutableString stringWithFormat:@"https://i.ytimg.com/vi/%@/maxresdefault.jpg", videoId];
            url = newURL;
        }
            [self.networkManager requestImageWithDateURL:url andCompliteon:^(UIImage * image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    APODItem *item = [APODItem new];
                    item.image = image;
                    completion(item);
                });
            }];
    }];
}

- (NSNumber *)increaseNumberOfRows:(NSNumber *)number {
    return @([number intValue] + 16);
}

- (NSString *) configureURL:(long)index {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.day = - (1 + index);
    NSDate *newDate = [[NSCalendar currentCalendar]dateByAddingComponents:dateComponents
                                                                   toDate: [NSDate date]
                                                                  options:0];
    NSString *resultDate = [dateFormatter stringFromDate:newDate];
    NSMutableString *url = [NSMutableString new];
    [url appendFormat:@"https://api.nasa.gov/planetary/apod?date=%@&api_key=yzHZv4gYjHdSaEIDHKmSqwN8onkNJ82chYma34OF",resultDate];
    
    return url;
}

@end
