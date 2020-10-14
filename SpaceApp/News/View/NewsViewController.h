//
//  NewsViewController.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/26/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel+CoreDataProperties.h"
#import "NewsCellItem.h"
#import "FavouriteViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSMutableArray<NewsModel*>* favouriteArray;
@property (nonatomic) NSMutableArray<NewsCellItem*>* favouriteItemsArray;
@property (nonatomic) FavouriteViewController *favVC;
@property (nonatomic) NSCache *cache;
@property (nonatomic) UITableView *tableView;
- (void)setupTableView;

@end

NS_ASSUME_NONNULL_END
