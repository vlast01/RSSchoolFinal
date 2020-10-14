//
//  AdditionalNewsViewController.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/29/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsCellItem.h"
#import "NewsModel+CoreDataProperties.h"
#import "FavouriteViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdditionalNewsViewController : UIViewController

@property (nonatomic) NewsCellItem *item;
@property (nonatomic) NSMutableArray<NewsModel*>* favouriteArray;
@property (nonatomic) NSMutableArray<NewsCellItem*>* favouriteItemsArray;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) FavouriteViewController *favVC;

@end

NS_ASSUME_NONNULL_END
