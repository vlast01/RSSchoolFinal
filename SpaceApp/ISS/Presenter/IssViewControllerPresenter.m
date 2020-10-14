//
//  IssViewControllerPresenter.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/31/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "IssViewControllerPresenter.h"
#import "NetworkManager.h"
#import <UserNotifications/UserNotifications.h>
#import "IssPassViewModel.h"

@implementation IssViewControllerPresenter

- (void)requestPassingWithLat:(NSString *)lat andLon:(NSString *)lon Compliteon: (void(^)(NSArray<IssPassViewModel *> *))completion {
    NetworkManager *networkManager = [NetworkManager new];
    [networkManager requestPassesWithLat:lat andLon:lon andCompliteon:^(NSArray<NSDictionary *> * dictArray) {
        NSMutableArray *resultArray = [NSMutableArray new];
        for (NSDictionary *dict in dictArray) {
            [self parseDataForIss:dict completion:^(IssPassViewModel *viewModel) {
                [resultArray addObject:viewModel];
            }];
        }
        completion(resultArray);
    }];
}

- (void)configureNotification:(NSString *)dateLabel {
    if (self.isGrantedNotificationAccess) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *mucontent = [[UNMutableNotificationContent alloc] init];
        int diff = [self calculateTiteInterval:dateLabel];
        mucontent.title = @"ISS flies by!";
        mucontent.body = @"ISS will fly by in 5 minutes";
        mucontent.sound = [UNNotificationSound defaultSound];
        
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:diff repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"UYLocalotification" content:mucontent trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:nil];
    }
}

- (int)calculateTiteInterval:(NSString *)dateLabel {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
    NSDate *date = [dateFormatter dateFromString:[dateLabel substringFromIndex:10]];
    NSString *resultString = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *date2 = [dateFormatter dateFromString:resultString];
    NSTimeInterval diff = [date timeIntervalSinceDate: date2] - 300;
    return (int)diff;
}

- (void)parseDataForIss:(NSDictionary *)dict completion:(void (^)(IssPassViewModel *))completion {
    IssPassViewModel *issPassModel = [IssPassViewModel new];
    NSTimeInterval _interval = [[dict objectForKey:@"risetime"] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
    NSString *dateString = [formatter stringFromDate:date];
    issPassModel.duration = [NSString stringWithFormat:@"Duration: %@ sec", [dict objectForKey:@"duration"]];
    issPassModel.risetime = [NSString stringWithFormat:@"Risetime: %@", dateString];
    completion(issPassModel);
}

@end
