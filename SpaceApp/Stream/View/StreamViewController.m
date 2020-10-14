//
//  StreamViewController.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/2/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "StreamViewController.h"
#import <WebKit/WebKit.h>
#import "StreamViewControllerPresenter.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface StreamViewController ()

@property (nonatomic) WKWebView *webView;
@property (nonatomic) UILabel *positionLabel;
@property (nonatomic) StreamViewControllerPresenter *streamPresenter;
@property (nonatomic) UIButton *refreshButton;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *contentView;
@property (nonatomic) MKMapView *mapView;

@end

@implementation StreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Stream";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.streamPresenter = [StreamViewControllerPresenter new];
    [self setupScrollView];
    [self setupContentView];
    [self setupWebView];
    [self setupMapView];
    [self setupConstraints];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshPosition) userInfo:nil repeats:YES];
}

- (void)setupScrollView {
    self.scrollView = [UIScrollView new];
    [self.view addSubview:self.scrollView];
}

- (void)setupContentView {
    self.contentView = [UIView new];
    [self.scrollView addSubview:self.contentView];
}

- (void)setupWebView {
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    self.webView.backgroundColor = [UIColor blackColor];
    NSURL *nsurl=[NSURL URLWithString:@"https://www.youtube.com/embed/DDU-rZs-Ic4"];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self.webView loadRequest:nsrequest];
    [self.contentView addSubview:self.webView];
}

- (void)setupMapView {
    self.mapView = [[MKMapView alloc] init];
    self.mapView.mapType = MKMapTypeHybrid;
    self.mapView.delegate = self;
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    [self.contentView addSubview: self.mapView];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(50, 50), 10000000, 10000000);
    MKCoordinateRegion adjustedRegion = [ self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];
}

- (void)setupConstraints {
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    self.positionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.refreshButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.mapView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
        [self.contentView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
        [self.webView.topAnchor constraintEqualToAnchor:self.contentView.safeAreaLayoutGuide.topAnchor],
        [self.webView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
        [self.webView.widthAnchor constraintEqualToConstant:[self calculateWidth]],
        [self.webView.heightAnchor constraintEqualToConstant:[self calculateWidth] / 2],
        [self.mapView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [self.mapView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [self.mapView.topAnchor constraintEqualToAnchor:self.webView.bottomAnchor constant:10],
        [self.mapView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor],
        [self.mapView.heightAnchor constraintEqualToConstant:self.view.frame.size.width],
        [self.mapView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-10],
    ]];
}

- (float)calculateWidth {
    if (self.view.frame.size.height > self.view.frame.size.width) {
        return self.view.frame.size.width;
    }
    else {
        return self.view.frame.size.height;
    }
}


- (void)refreshPosition {
    [self.streamPresenter requestIssPositionWithCompliteon:^(IssPositionModelItem * position) {
        [self.mapView removeAnnotations:self.mapView.annotations];
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:CLLocationCoordinate2DMake(position.latitude, position.longitude)];
        [self.mapView addAnnotation:annotation];
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *SFAnnotationIdentifier = @"SFAnnotationIdentifier";
    MKPinAnnotationView *pinView =
    (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:SFAnnotationIdentifier];
    if (!pinView) {
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                        reuseIdentifier:SFAnnotationIdentifier];
        UIImage *flagImage = [UIImage imageNamed:@"ISS-icon"];
        annotationView.image = flagImage;
        return annotationView;
    }
    else {
        pinView.annotation = annotation;
    }
    return pinView;
}


@end
