//
//  FavouriteViewController.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/4/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "FavouriteViewController.h"
#import "NewsCell.h"
#import "AdditionalNewsViewController.h"

@interface FavouriteViewController ()

@end

@implementation FavouriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Favourite";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.view.backgroundColor = [UIColor blackColor];
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView = [UITableView new];
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.tableView];
    [self setupTableViewConstraints];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:NewsCell.class forCellReuseIdentifier:@"cellId"];
}

- (void)setupTableViewConstraints {
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
    ]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favouriteItemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *newsCell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    newsCell.indexPathRow = (int)indexPath.row;
    [newsCell setupCell];
    newsCell.label.text = self.favouriteItemsArray[self.favouriteItemsArray.count - (int)indexPath.row - 1].name;
    newsCell.customImageView.image = self.favouriteItemsArray[self.favouriteItemsArray.count - (int)indexPath.row - 1].image;
    return newsCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    AdditionalNewsViewController *additionalViewController = [AdditionalNewsViewController new];
    additionalViewController.favouriteArray = self.favouriteArray;
    additionalViewController.favouriteItemsArray = self.favouriteItemsArray;
    additionalViewController.favVC = self;
    [self.navigationController pushViewController:additionalViewController animated:YES];
    additionalViewController.item = self.favouriteItemsArray[self.favouriteItemsArray.count - (int)indexPath.row - 1];
}



@end
