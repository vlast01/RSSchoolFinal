//
//  ViewModelItem.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/26/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewModelItem : NSObject

@property (nonatomic) NSString* ID;
@property (nonatomic) NSString* url;
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* publication;
@property (nonatomic) NSString* abstract;
@property (nonatomic) NSString* thumbnail;
@property (nonatomic) UIImage *image;
- (id)initWithID:(NSString *)ID;
- (void)parseDataForArticle:(NSDictionary *)dict completion:(void(^)(ViewModelItem *))completion;

@end

NS_ASSUME_NONNULL_END
