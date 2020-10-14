//
//  APODViewController.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/25/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "APODViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "APODCollectionViewCell.h"
#import "LoadingCollectionViewCell.h"
#import "APODViewControllerPresenter.h"
#import "APODItem.h"
#import "ModalViewController.h"

@interface APODViewController ()

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSNumber *numberOfCells;
@property (nonatomic) BOOL loadingMoreTableViewData;
@property (nonatomic) APODViewControllerPresenter *presenter;

@end

@implementation APODViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupCollectionView];
    [self setupConstraints];
    self.presenter = [APODViewControllerPresenter new];
}

- (void)setupCollectionView {
    self.title = @"APOD";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.numberOfCells = @(17);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[APODCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionView registerClass:[LoadingCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier2"];
    self.collectionView.backgroundColor = [UIColor blackColor];
}

- (void)setupConstraints {
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.collectionView.topAnchor constraintLessThanOrEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
    ]];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize newSize = CGSizeZero;
    if ((long)indexPath.row == ([self.numberOfCells longValue] - 1)) {
        newSize.height = 50;
        newSize.width = self.view.frame.size.width - 10;
        return newSize;
    }
    if (self.view.frame.size.height > self.view.frame.size.width) {
        
        newSize.height = (self.view.frame.size.width - 15) / 3;
        
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        CGSize screenSize = screenBounds.size;
        
        if (indexPath.item % 4 == 0 || indexPath.item % 4 == 3) {
            newSize.width = newSize.height;
        }
        else {
            newSize.width = screenSize.width - newSize.height - 20;
        }
    }
    else {
        newSize.height = self.view.frame.size.width / 3;
        
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        CGSize screenSize = screenBounds.size;
        
        if (indexPath.item % 4 == 0 || indexPath.item % 4 == 3) {
            newSize.width = newSize.height;
        }
        else {
            newSize.width = screenSize.width - newSize.height - 25;
        }
    }
    return newSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 5.0, 10, 5.0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.numberOfCells intValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((long)indexPath.row == ([self.numberOfCells longValue] - 1)) {
        LoadingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier2" forIndexPath:indexPath];
        [cell setupCell];
        if (!self.loadingMoreTableViewData) {
            
            self.loadingMoreTableViewData = YES;
            [self performSelector:@selector(addSomeMoreEntriesToCollectionView) withObject:nil afterDelay:2.0f];
            
        }
        return cell;
    }
    
    APODCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    [cell setupCell];
    
    if ([self.cache objectForKey:[NSString stringWithFormat:@"%@",indexPath]] != nil) {
        APODItem *item = [self.cache objectForKey:[NSString stringWithFormat:@"%@",indexPath]];
        cell.customImageView.image = item.image;
    }
    else {
        [self.presenter getImageForIndexPath:(long)indexPath.row andCompletion:^(APODItem * item) {
           APODCollectionViewCell *cell = (APODCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
            cell.item = item;
            cell.customImageView.image = item.image;
            [self.cache setObject:item forKey:[NSString stringWithFormat:@"%@",indexPath]];
        }];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ((long)indexPath.row != ([self.numberOfCells longValue]-1) && [self.cache objectForKey:[NSString stringWithFormat:@"%@",indexPath]] != nil) {
        ModalViewController *modalVC = [ModalViewController new];
        modalVC.item = [self.cache objectForKey:[NSString stringWithFormat:@"%@",indexPath]];
        [self presentViewController:modalVC animated:YES completion:nil];
    }
}

- (void)addSomeMoreEntriesToCollectionView {
    
    self.numberOfCells = [self.presenter increaseNumberOfRows:self.numberOfCells];
    self.loadingMoreTableViewData = NO;
    [self.collectionView reloadData];
}

@end
