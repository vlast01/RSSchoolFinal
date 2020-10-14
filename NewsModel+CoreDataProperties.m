//
//  NewsModel+CoreDataProperties.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 9/4/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//
//

#import "NewsModel+CoreDataProperties.h"

@implementation NewsModel (CoreDataProperties)

+ (NSFetchRequest<NewsModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"NewsModel"];
}

@dynamic idString;
@dynamic name;
@dynamic publication;
@dynamic abstract;
@dynamic thumbnail;

@end
