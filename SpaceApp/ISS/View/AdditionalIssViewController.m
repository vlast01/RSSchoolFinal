//
//  AdditionalIssViewController.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/31/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "AdditionalIssViewController.h"
#import "IssCell.h"
#import "IssViewControllerPresenter.h"
#import "IssPassViewModel.h"
#import <UserNotifications/UserNotifications.h>

@interface AdditionalIssViewController ()

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray <IssPassViewModel *> *dataSourceArray;
@property (nonatomic) BOOL isGrantedNotificationAccess;
@property (nonatomic) UIActivityIndicatorView *spinner;

@end

@implementation AdditionalIssViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUNUserNotificationCenter];
    [self setupActivityIndicatorView];
    self.view.backgroundColor = [UIColor blackColor];
    IssViewControllerPresenter *issPresenter = [IssViewControllerPresenter new];
    [issPresenter requestPassingWithLat:(NSString *)self.lat andLon:(NSString *)self.lon Compliteon:^(NSArray<IssPassViewModel *> * array) {
        self.dataSourceArray = array;
        [self.spinner removeFromSuperview];
        [self setupTableView];
        [self setupConstraints];
    }];
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

- (void)setupTableView {
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.tableView setSeparatorColor:[UIColor grayColor]];
    [self.tableView registerClass:IssCell.class forCellReuseIdentifier:@"cellId"];
}

- (void)setupConstraints {
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
    ]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IssCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    [cell setupCell];
    cell.dateLabel.text = self.dataSourceArray[(int)indexPath.row].risetime;
    cell.durationLabel.text = self.dataSourceArray[(int)indexPath.row].duration;
    cell.isGrantedNotificationAccess = self.isGrantedNotificationAccess;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.parentVC = self;
    return cell;
}

- (void)setupUNUserNotificationCenter {
    self.isGrantedNotificationAccess = NO;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions: options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        self.isGrantedNotificationAccess = granted;
        
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
