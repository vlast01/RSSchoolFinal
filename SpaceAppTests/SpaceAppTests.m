//
//  SpaceAppTests.m
//  SpaceAppTests
//
//  Created by Владислав Станкевич on 8/25/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "APODViewControllerPresenter.h"
#import "StreamViewControllerPresenter.h"
#import "IssPositionModelItem.h"
#import "IssViewControllerPresenter.h"
#import "IssPassViewModel.h"
#import "NewsViewControllerPresenter.h"
#import "NewsCellItem.h"

@interface SpaceAppTests : XCTestCase

@end

@implementation SpaceAppTests

- (void)testConfigureURL {
    
    APODViewControllerPresenter *presenter = [APODViewControllerPresenter new];
    NSString *result = [presenter configureURL:1];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.day = - 2;
    NSDate *newDate = [[NSCalendar currentCalendar]dateByAddingComponents:dateComponents
                                                                   toDate: [NSDate date]
                                                                  options:0];
    NSString *resultDate = [dateFormatter stringFromDate:newDate];
    NSMutableString *url = [NSMutableString new];
    [url appendFormat:@"https://api.nasa.gov/planetary/apod?date=%@&api_key=yzHZv4gYjHdSaEIDHKmSqwN8onkNJ82chYma34OF",resultDate];
    XCTAssertTrue([result isEqualToString: url]);
}

- (void)testRequestIssPosition {
    StreamViewControllerPresenter *presenter = [StreamViewControllerPresenter new];
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Get position"];
    [presenter requestIssPositionWithCompliteon:^(IssPositionModelItem * item) {
        [expectation fulfill];
        XCTAssertTrue(item.latitude > -180 && item.latitude < 180);
        XCTAssertTrue(item.longitude > -180 && item.longitude < 180);
    }];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testConfigureNotification {
    IssViewControllerPresenter *presenter = [IssViewControllerPresenter new];
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Get passes"];
    [presenter requestPassingWithLat:@"50" andLon:@"50" Compliteon:^(NSArray<IssPassViewModel *> * itemArray) {
        [expectation fulfill];
        XCTAssertTrue(itemArray.count > 0);
        XCTAssertTrue([itemArray[0].duration containsString:@"Duration"]);
    }];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testCalculateTiteInterval {
    IssViewControllerPresenter *presenter = [IssViewControllerPresenter new];
    long interval = [presenter calculateTiteInterval:@"Risetime: 09-06-2020 11:11"];
    XCTAssertTrue(interval < 0);
}

- (void)testRequestNews {
    NewsViewControllerPresenter *presenter = [NewsViewControllerPresenter new];
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Get news"];
    [presenter requestNewsWithCompletion:^(NSArray<NSDictionary *> * array) {
        [expectation fulfill];
        XCTAssertTrue(array.count > 100);
    }];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testRequestArticleWithID {
    NewsViewControllerPresenter *presenter = [NewsViewControllerPresenter new];
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Get article"];
    [presenter requestArticleWithID:@"2020-46" andCompliteon:^(NewsCellItem * item) {
        [expectation fulfill];
        XCTAssertTrue([item.abstract containsString:@"Looks"]);
    }];
    [self waitForExpectations:@[expectation] timeout:10];
}

@end
