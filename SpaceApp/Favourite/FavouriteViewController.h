//
//  FavouriteViewController.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/4/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel+CoreDataProperties.h"
#import "NewsCellItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavouriteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSMutableArray<NewsModel*>* favouriteArray;
@property (nonatomic) NSMutableArray<NewsCellItem*>* favouriteItemsArray;

@end

NS_ASSUME_NONNULL_END
