//
//  AdditionalIssViewController.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/31/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface AdditionalIssViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSString * lat;
@property (nonatomic) NSString * lon;


@end

NS_ASSUME_NONNULL_END
