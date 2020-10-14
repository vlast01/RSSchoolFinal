//
//  TabBarController.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/25/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "TabBarController.h"
#import "APODViewController.h"
#import "NEOWSViewController.h"
#import "NewsViewController.h"
#import "IssViewController.h"
#import "StreamViewController.h"
#import "AppDelegate.h"
#import "NewsModel+CoreDataProperties.h"
#import "NewsCellItem.h"
#import "NewsViewControllerPresenter.h"
#import "FavouriteViewController.h"

@interface TabBarController ()

@property (nonatomic) NSCache *cache;
@property (nonatomic) FavouriteViewController *favouriteViewController;
@property (nonatomic) NewsViewController *newsViewController;

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cache = [NSCache new];
    
    self.tabBar.tintColor = [UIColor whiteColor];
    self.tabBar.barTintColor = [UIColor blackColor];
    
    NSMutableArray<NewsModel*>* favouriteArray = [self fetchNews];
    NSMutableArray<NewsCellItem*>* favouriteItemsArray = [self convertModelsToItems:favouriteArray];
    
    UINavigationController *issNavController = [UINavigationController new];
    UINavigationController *aPODnavController = [UINavigationController new];
    UINavigationController *newsNavController = [UINavigationController new];
    UINavigationController *streamNavController = [UINavigationController new];
    UINavigationController *favouriteNavController = [UINavigationController new];
    newsNavController.navigationBar.tintColor = [UIColor whiteColor];
    newsNavController.navigationBar.barTintColor = [UIColor blackColor];
    issNavController.navigationBar.tintColor = [UIColor whiteColor];
    issNavController.navigationBar.barTintColor = [UIColor blackColor];
    aPODnavController.navigationBar.tintColor = [UIColor whiteColor];
    aPODnavController.navigationBar.barTintColor = [UIColor blackColor];
    streamNavController.navigationBar.tintColor = [UIColor whiteColor];
    streamNavController.navigationBar.barTintColor = [UIColor blackColor];
    favouriteNavController.navigationBar.tintColor = [UIColor whiteColor];
    favouriteNavController.navigationBar.barTintColor = [UIColor blackColor];
    
    self.viewControllers = @[newsNavController, issNavController, streamNavController, aPODnavController, favouriteNavController];
    
    IssViewController *issViewController = [IssViewController new];
    issNavController.viewControllers = @[issViewController];
    APODViewController *aPODViewController = [APODViewController new];
    aPODViewController.cache = self.cache;
    aPODnavController.viewControllers = @[aPODViewController];
    
    StreamViewController *streamViewController = [StreamViewController new];
    streamNavController.viewControllers = @[streamViewController];
    self.favouriteViewController = [FavouriteViewController new];
    self.favouriteViewController.favouriteArray = favouriteArray;
    self.favouriteViewController.favouriteItemsArray = favouriteItemsArray;
    favouriteNavController.viewControllers = @[self.favouriteViewController];
    self.newsViewController = [NewsViewController new];
    self.newsViewController.cache = self.cache;
    self.newsViewController.favouriteArray = favouriteArray;
    self.newsViewController.favouriteItemsArray = favouriteItemsArray;
    self.newsViewController.favVC = self.favouriteViewController;
    newsNavController.viewControllers = @[self.newsViewController];
    
    
    aPODnavController.tabBarItem.title = @"APOD";
    newsNavController.tabBarItem.title = @"News";
    issNavController.tabBarItem.title = @"ISS";
    streamNavController.tabBarItem.title = @"Stream";
    favouriteNavController.tabBarItem.title = @"Favourite";
    
    newsNavController.tabBarItem.image = [UIImage imageNamed:@"news"];
    issNavController.tabBarItem.image = [UIImage imageNamed:@"satellite"];
    streamNavController.tabBarItem.image = [UIImage imageNamed:@"stream"];
    favouriteNavController.tabBarItem.image = [UIImage imageNamed:@"favourite"];
    aPODnavController.tabBarItem.image = [UIImage imageNamed:@"APOD"];
}

- (NSManagedObjectContext *)viewContext {
    return ((AppDelegate *)UIApplication.sharedApplication.delegate).persistentContainer.viewContext;
}

- (NSManagedObjectContext *)newBackgroundContext {
    return ((AppDelegate *)UIApplication.sharedApplication.delegate).persistentContainer.newBackgroundContext;
}

- (NSMutableArray<NewsModel*>*)fetchNews{
    
    NSManagedObjectContext *context = [self viewContext];
    NSFetchRequest *fetchRequest = [NewsModel fetchRequest];
    return [context executeFetchRequest:fetchRequest error:nil];
}

- (NSMutableArray<NewsCellItem*>*)convertModelsToItems:(NSMutableArray<NewsModel*>*)favouriteArray {
    NSMutableArray<NewsCellItem*>* favouriteItemsArray = [NSMutableArray new];
    NewsViewControllerPresenter *presenter = [NewsViewControllerPresenter new];
    for (NewsModel *newsModel in favouriteArray) {
        NewsCellItem *item = [NewsCellItem new];
        item.ID = newsModel.idString;
        item.abstract = newsModel.abstract;
        item.name = newsModel.name;
        item.publication = newsModel.publication;
        item.thumbnail = newsModel.thumbnail;
        item.liked = @"1";
        [presenter getImageForURL:item.thumbnail andCompletion:^(UIImage * image) {
            item.image = image;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.favouriteViewController.tableView reloadData];
                [self.newsViewController.tableView reloadData];
            });
            
        }];
        [favouriteItemsArray addObject:item];
    }
    return favouriteItemsArray;
}


@end
