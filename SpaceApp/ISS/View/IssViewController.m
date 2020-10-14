//
//  IssViewController.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/30/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "IssViewController.h"
#import "AdditionalIssViewController.h"

@interface IssViewController ()

@property (nonatomic) UIPickerView *pickerView;
@property (nonatomic) NSArray *citiesArray;
@property (nonatomic) UITextField *textField;
@property (nonatomic) UIButton *searchButton;
@property (nonatomic) UILabel *headerLabel;
@property (nonatomic) UILabel *headerAdditionalLabel;
@property (nonatomic) UILabel *locationLabel;
@property (nonatomic) UIView *customView;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *contentView;
@property (nonatomic) UIImageView *customImageView;

@end

@implementation IssViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ISS";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.citiesArray = @[@" Minsk",  @" Grodno", @" Brest", @" Gomel", @" Mogilev", @" Vitebsk", @" Kiev", @" Warsaw"];
    [self setupScrollView];
    [self setupContentView];
    [self setupCustomView];
    [self setupLocationLabel];
    [self setupPickerView];
    [self setupTextField];
    [self setupSearchButton];
    [self setupHeaderLabel];
    [self setupHeaderAdditionalLabel];
    [self setupCustomImageView];
    [self setupConstraints];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
}

- (void)setupScrollView {
    self.scrollView = [UIScrollView new];
    [self.view addSubview:self.scrollView];
}

- (void)setupContentView {
    self.contentView = [UIView new];
    [self.scrollView addSubview:self.contentView];
}

- (void)setupPickerView {
    self.pickerView = [UIPickerView new];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.backgroundColor = [UIColor whiteColor];
}

- (void)setupHeaderLabel {
    self.headerLabel = [UILabel new];
    self.headerLabel.textColor = [UIColor whiteColor];
    self.headerLabel.text = @"Find ISS";
    self.headerLabel.font = [UIFont systemFontOfSize:25 weight:UIFontWeightMedium];
    [self.contentView addSubview:self.headerLabel];
}

- (void)setupHeaderAdditionalLabel {
    self.headerAdditionalLabel = [UILabel new];
    self.headerAdditionalLabel.textColor = [UIColor whiteColor];
    self.headerAdditionalLabel.text = @"Check when you can see it!";
    self.headerAdditionalLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightThin];
    [self.contentView addSubview:self.headerAdditionalLabel];
}

- (void)setupCustomView {
    self.customView = [UIView new];
    [self.contentView addSubview:self.customView];
    self.customView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.3];
    self.customView.layer.cornerRadius = 15;
}

- (void)setupTextField {
    self.textField = [UITextField new];
    [self.customView addSubview:self.textField];
    self.textField.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:0.1];
    self.textField.textColor = [UIColor whiteColor];
    self.textField.alpha = 1;
    self.textField.layer.cornerRadius = 10;
    self.textField.allowsEditingTextAttributes = NO;
    self.textField.delegate = self;
    self.textField.inputView = self.pickerView;
    self.textField.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    self.textField.placeholder = @" Choose city";
}

- (void)setupLocationLabel {
    self.locationLabel = [UILabel new];
    self.locationLabel.textColor = [UIColor whiteColor];
    [self.customView addSubview:self.locationLabel];
    self.locationLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    self.locationLabel.text = @"Select your location";
}

- (void)setupSearchButton {
    self.searchButton = [UIButton new];
    [self.customView addSubview:self.searchButton];
    [self.searchButton setTitle:@"Search" forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(searchTapped) forControlEvents:UIControlEventTouchUpInside];
    self.searchButton.layer.cornerRadius = 10;
    self.searchButton.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:0.5];
}

- (void)setupCustomImageView {
    self.customImageView = [UIImageView new];
    self.customImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.customImageView.image = [UIImage imageNamed:@"iss"];
    [self.contentView addSubview:self.customImageView];
}

- (void)setupConstraints {
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerAdditionalLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.customView.translatesAutoresizingMaskIntoConstraints = NO;
    self.locationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.searchButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.customImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
        [self.contentView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
        [self.headerLabel.topAnchor constraintEqualToAnchor:self.contentView.safeAreaLayoutGuide.topAnchor constant:10],
        [self.headerLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
        [self.headerAdditionalLabel.topAnchor constraintEqualToAnchor:self.headerLabel.bottomAnchor constant:10],
        [self.headerAdditionalLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
        [self.customImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [self.customImageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [self.customImageView.topAnchor constraintEqualToAnchor:self.headerAdditionalLabel.topAnchor constant:10],
        [self.customImageView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor],
        [self.customView.topAnchor constraintEqualToAnchor:self.customImageView.bottomAnchor constant:0],
        [self.customView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
        [self.customView.heightAnchor constraintEqualToConstant:250],
        [self.customView.widthAnchor constraintEqualToConstant:300],
        [self.customView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-150],
        [self.locationLabel.topAnchor constraintEqualToAnchor:self.customView.topAnchor constant:35],
        [self.locationLabel.centerXAnchor constraintEqualToAnchor:self.customView.centerXAnchor],
        [self.textField.centerXAnchor constraintEqualToAnchor:self.customView.centerXAnchor],
        [self.textField.centerYAnchor constraintEqualToAnchor:self.customView.centerYAnchor],
        [self.textField.widthAnchor constraintEqualToConstant:200],
        [self.textField.heightAnchor constraintEqualToConstant:50],
        [self.searchButton.centerXAnchor constraintEqualToAnchor:self.customView.centerXAnchor],
        [self.searchButton.bottomAnchor constraintEqualToAnchor:self.customView.bottomAnchor constant:-35],
        [self.searchButton.heightAnchor constraintEqualToConstant:35],
        [self.searchButton.widthAnchor constraintEqualToConstant:100],
    ]];
}

- (void)searchTapped {
    AdditionalIssViewController *additionalIssViewController = [AdditionalIssViewController new];
    if ([self.textField.text isEqual: @""]){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sorry"
                                                                       message:@"Enter location"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    else if ([self.textField.text isEqual: @" Minsk"]) {
        additionalIssViewController.lat = @"53.893009";
        additionalIssViewController.lon = @"27.567444";
    }
    else if ([self.textField.text isEqual: @" Grodno"]) {
        additionalIssViewController.lat = @"53.669353";
        additionalIssViewController.lon = @"23.813131";
    }
    else if ([self.textField.text isEqual: @" Brest"]) {
        additionalIssViewController.lat = @"52.097622";
        additionalIssViewController.lon = @"23.734051";
    }
    else if ([self.textField.text isEqual: @" Gomel"]) {
        additionalIssViewController.lat = @"52.4345";
        additionalIssViewController.lon = @"30.9754";
    }
    else if ([self.textField.text isEqual: @" Mogilev"]) {
        additionalIssViewController.lat = @"53.9168";
        additionalIssViewController.lon = @"30.3449";
    }
    else if ([self.textField.text isEqual: @" Vitebsk"]) {
        additionalIssViewController.lat = @"55.1904";
        additionalIssViewController.lon = @"30.2049";
    }
    else if ([self.textField.text isEqual: @" Kiev"]) {
        additionalIssViewController.lat = @"50.431759";
        additionalIssViewController.lon = @"30.517023";
    }
    else if ([self.textField.text isEqual: @" Warsaw"]) {
        additionalIssViewController.lat = @"52.22977";
        additionalIssViewController.lon = @"21.01178";
    }
    
    
    [self.navigationController pushViewController:additionalIssViewController animated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.citiesArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.citiesArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.textField.text = self.citiesArray[row];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return NO;
}

- (void)dismissKeyboard {
    [self.pickerView removeFromSuperview];
    [self.textField endEditing:YES];
}


@end
