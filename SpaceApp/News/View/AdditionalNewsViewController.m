//
//  AdditionalNewsViewController.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/29/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "AdditionalNewsViewController.h"
#import "NewsModel+CoreDataProperties.h"
#import "AppDelegate.h"

@interface AdditionalNewsViewController ()

@property (nonatomic)UIScrollView* scrollView;
@property (nonatomic)UIView *contentView;
@property (nonatomic)UILabel *textLabel;
@property (nonatomic)UIImageView *customImageView;
@property (nonatomic)UILabel *publication;
@property (nonatomic)UIButton *likeButton;
@property (nonatomic)UIButton *shareButton;

@end

@implementation AdditionalNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupScrollView];
    [self setupContentView];
    [self setupImageView];
    [self setupPublication];
    [self setupTextLabel];
    [self setupLikeButton];
    [self setupShareButton];
    [self setupLayout];
}

- (void)setupScrollView {
    self.scrollView = [UIScrollView new];
    [self.view addSubview:self.scrollView];
}

- (void)setupContentView {
    self.contentView = [UIView new];
    [self.scrollView addSubview:self.contentView];
}

- (void)setupImageView {
    self.customImageView = [UIImageView new];
    self.customImageView.image = self.item.image;
    self.customImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.customImageView];
}

- (void)setupPublication {
    self.publication = [UILabel new];
    [self.contentView addSubview:self.publication];
    self.publication.text = [NSString stringWithFormat:@"Date: %@",[self.item.publication substringToIndex:10]];
    self.publication.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    self.publication.textColor = [UIColor whiteColor];
    self.publication.numberOfLines = 0;
}

- (void)setupTextLabel {
    self.textLabel = [UILabel new];
    [self.contentView addSubview:self.textLabel];
    self.textLabel.text = self.item.abstract;
    self.textLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.numberOfLines = 0;
}

- (void)setupLikeButton {
    self.likeButton = [UIButton new];
    if ([self.item.liked isEqualToString:@"1"]) {
        [self.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"nolike"] forState:UIControlStateSelected];
    }
    else{
        [self.likeButton setImage:[UIImage imageNamed:@"nolike"] forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateSelected];
    }
    [self.likeButton addTarget:self action:@selector(likeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.likeButton];
}

- (void)setupShareButton {
    self.shareButton = [UIButton new];
    [self.shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.shareButton];
    [self.shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupLayout {
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.customImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.publication.translatesAutoresizingMaskIntoConstraints = NO;
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.likeButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
        [self.contentView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
        [self.customImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [self.customImageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [self.customImageView.topAnchor constraintEqualToAnchor:self.contentView.safeAreaLayoutGuide.topAnchor],
        [self.customImageView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor],
        [self.publication.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10],
        [self.publication.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [self.publication.topAnchor constraintEqualToAnchor:self.customImageView.bottomAnchor constant:10],
        [self.likeButton.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10],
        [self.likeButton.heightAnchor constraintEqualToConstant:40],
        [self.likeButton.widthAnchor constraintEqualToConstant:40],
        [self.likeButton.topAnchor constraintEqualToAnchor:self.publication.bottomAnchor constant:10],
        [self.shareButton.leadingAnchor constraintEqualToAnchor:self.likeButton.trailingAnchor constant:10],
        [self.shareButton.topAnchor constraintEqualToAnchor:self.likeButton.topAnchor],
        [self.shareButton.widthAnchor constraintEqualToConstant:40],
        [self.shareButton.heightAnchor constraintEqualToConstant:40],
        [self.textLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10],
        [self.textLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10],
        [self.textLabel.topAnchor constraintEqualToAnchor:self.likeButton.bottomAnchor constant:10],
        [self.textLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
    ]];
}

- (void)likeButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    UIImpactFeedbackGenerator *myGen = [[UIImpactFeedbackGenerator alloc] initWithStyle:(UIImpactFeedbackStyleLight)];
    [myGen impactOccurred];
    myGen = NULL;
    
    NSManagedObjectContext *context = [self viewContext];
    
    [context performBlockAndWait:^{
        if ([self.item.liked isEqualToString:@"0"]) {
            __block  NewsModel *newsModel;
            newsModel = [[NewsModel alloc] initWithContext:context];
            newsModel.idString = self.item.ID;
            newsModel.abstract = self.item.abstract;
            newsModel.name = self.item.name;
            newsModel.publication = self.item.publication;
            newsModel.thumbnail = self.item.thumbnail;
            self.item.liked = @"1";
            [self.favouriteItemsArray addObject:self.item];
        }
        else {
            for (NewsModel *newsModel in self.favouriteArray) {
                if ([newsModel.idString isEqualToString:self.item.ID] ) {
                    [context deleteObject:newsModel];
                    break;
                }
            }
            self.item.liked = @"0";
            [self.favouriteItemsArray removeObject:self.item];
        }
        [self.favVC.tableView reloadData];
    }];
    
    [context save:nil];
}

- (NSManagedObjectContext *)viewContext {
    return ((AppDelegate *)UIApplication.sharedApplication.delegate).persistentContainer.viewContext;
}

- (NSManagedObjectContext *)newBackgroundContext {
    return ((AppDelegate *)UIApplication.sharedApplication.delegate).persistentContainer.newBackgroundContext;
}

- (void)share {
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[self.item.image] applicationActivities:nil];
    //if iPhone
    if ([[UIDevice currentDevice].model hasPrefix:@"iPhone"]) {
        [self presentViewController:controller animated:YES completion:nil];
    }
    //if iPad
    else {
        controller.modalPresentationStyle = UIModalPresentationPopover;
        [self presentViewController:controller animated:true completion:nil];
        UIPopoverPresentationController *presentationController =
        [controller popoverPresentationController];
        presentationController.permittedArrowDirections =
        UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight;
        presentationController.sourceView = self.view;
        presentationController.sourceRect = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0);
        
    }
}

@end
