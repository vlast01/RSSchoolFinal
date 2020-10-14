//
//  NEOWSViewController.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/25/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "NEOWSViewController.h"
#import <WebKit/WebKit.h>

@interface NEOWSViewController ()

@end

@implementation NEOWSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIView *contentView = [UIView new];
//    contentView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:contentView];
//    contentView.translatesAutoresizingMaskIntoConstraints = NO;
//
//    contentView.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width/2);
//
//    [NSLayoutConstraint activateConstraints:@[
//        [contentView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
//        [contentView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
//    ]];
    

    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    NSURL *nsurl=[NSURL URLWithString:@"https://www.youtube.com/embed/DDU-rZs-Ic4"];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [webView loadRequest:nsrequest];
    [self.view addSubview:webView];
    
    webView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [webView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [webView.widthAnchor constraintEqualToConstant:self.view.frame.size.width],
      //  [webView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [webView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [webView.heightAnchor constraintEqualToConstant:self.view.frame.size.width/2],
    ]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
