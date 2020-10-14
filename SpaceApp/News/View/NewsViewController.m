//
//  NewsViewController.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/26/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCell.h"
#import "NewsViewControllerPresenter.h"
#import "AdditionalNewsViewController.h"
#import "NewsCellItem.h"

@interface NewsViewController ()

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *contentView;
@property (nonatomic) NSArray *idDataSourseArray;
@property (nonatomic) NewsViewControllerPresenter *newsViewControllerPresenter;
@property (nonatomic) UIActivityIndicatorView *spinner;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"News";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.newsViewControllerPresenter = [NewsViewControllerPresenter new];
    [self setupActivityIndicatorView];
    [self.newsViewControllerPresenter requestNewsWithCompletion:^(NSArray* list) {
        [self.spinner removeFromSuperview];
        [self setupTableView];
        self.idDataSourseArray = list;
        [self.tableView reloadData];
    }];
    
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

- (void)setupActivityIndicatorView {
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    self.spinner.color = [UIColor whiteColor];
    self.spinner.frame = CGRectMake(0, 0, 50, 50);
    [self.view addSubview:self.spinner];
    self.spinner.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.spinner.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.spinner.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
    ]];
    [self.spinner startAnimating];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.idDataSourseArray.count == 0) {
        return 0;
    }
    else
        return self.idDataSourseArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    for (NewsCellItem *item in self.favouriteItemsArray) {
        if ([item.ID isEqualToString:self.idDataSourseArray[(int)indexPath.row]]) {
            [self.cache setObject:item forKey:[NSString stringWithFormat:@"%d", (int)indexPath.row]];
            break;
        }
    }
    
    NewsCell *newsCell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    newsCell.indexPathRow = (int)indexPath.row;
    [newsCell setupCell];
    
    if ([self.cache objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.row]] != nil) {
        NewsCellItem *item = [self.cache objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.row]];
        newsCell.label.text = item.name;
        newsCell.customImageView.image = item.image;
    }
    
    else {
        [self.newsViewControllerPresenter requestArticleWithID:self.idDataSourseArray[newsCell.indexPathRow] andCompliteon:^(NewsCellItem * item) {
            NewsCell *newsCell = [tableView cellForRowAtIndexPath:indexPath];
            newsCell.label.text = item.name;
            [self.newsViewControllerPresenter getImageForURL:item.thumbnail andCompletion:^(UIImage * image) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    item.image = image;
                    item.liked = @"0";
                    item.ID = self.idDataSourseArray[newsCell.indexPathRow];
                    NewsCell *newsCell = [tableView cellForRowAtIndexPath:indexPath];
                    newsCell.customImageView.image = image;
                    [self.cache setObject:item forKey:[NSString stringWithFormat:@"%d", (int)indexPath.row]];
                });
            }];
            
        }];
    }
    
    return newsCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    if ([self.cache objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.row]] != nil) {
        AdditionalNewsViewController *additionalViewController = [AdditionalNewsViewController new];
        additionalViewController.favouriteArray = self.favouriteArray;
        additionalViewController.favouriteItemsArray = self.favouriteItemsArray;
        additionalViewController.favVC = self.favVC;
        [self.navigationController pushViewController:additionalViewController animated:YES];
        additionalViewController.item = [self.cache objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.row]];
    }
}




@end
