//
//  ModalViewController.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/6/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APODItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModalViewController : UIViewController

@property (nonatomic) APODItem *item;

@end

NS_ASSUME_NONNULL_END
