//
//  NewsModel+CoreDataProperties.h
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/4/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//
//

#import "NewsModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NewsModel (CoreDataProperties)

+ (NSFetchRequest<NewsModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *idString;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *publication;
@property (nullable, nonatomic, copy) NSString *abstract;
@property (nullable, nonatomic, copy) NSString *thumbnail;

@end

NS_ASSUME_NONNULL_END
