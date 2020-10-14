//
//  Model.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/27/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "Model.h"
#import "NetworkManager.h"

@implementation Model

- (NSString *)parseNewsID:(NSDictionary *)dictionary {
        NSString *ID = [dictionary objectForKey:@"url"];
    return [ID substringFromIndex:ID.length-7];
}

@end
