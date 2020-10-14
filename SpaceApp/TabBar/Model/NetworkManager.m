//
//  NetworkManager.m
//  SpaceApp
//
//  Created by Владислав Станкевич on 8/26/20.
//  Copyright © 2020 Владислав Станкевич. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

- (NSMutableURLRequest *)makeNewsArrayGetRequest {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://hubblesite.org/api/v3/news?page=all"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    return request;
}

- (NSDictionary *)makeEmptyHeader {
    NSDictionary *headers = @{ @"x-api-key": @"DEMO-API-KEY" };
    return headers;
}

- (NSMutableURLRequest *)configureNewsArrayGetRequest {
    NSDictionary *headers = [self makeEmptyHeader];
    NSMutableURLRequest *request = [self makeNewsArrayGetRequest];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    return request;
}

- (void)requestNewsWithCompliteon:(void (^)(NSArray<NSDictionary *> *))completion {
    
    NSMutableURLRequest *request = [self configureNewsArrayGetRequest];
    NSMutableArray *array = [NSMutableArray new];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
        } else {
            NSError *e = nil;
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
            for(NSDictionary *item in jsonArray) {
                [array addObject:item];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(array);
            });
        }
    }];
    [dataTask resume];
}

- (NSMutableURLRequest *)makeNewsArrayGetRequest:(NSString *)ID {
    
    NSString *link = [self configureArticleLink:ID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:link]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    return request;
}

- (NSMutableURLRequest *)configureArticleGetRequest:(NSString *)ID {
    NSDictionary *headers = [self makeEmptyHeader];
    NSMutableURLRequest *request = [self makeNewsArrayGetRequest:ID];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    return request;
}

- (void)requestArticleWithID:(NSString *)ID andCompliteon:(void (^)(NSDictionary *))completion {
    
    NSMutableURLRequest *request = [self configureArticleGetRequest:ID];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
        } else {
            NSError *e = nil;
            NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(jsonArray);
            });
        }
    }];
    
    [dataTask resume];
}

- (void)requestImageWithURL:(NSString *)url andCompliteon:(void (^)(UIImage *))completion {
    NSMutableString *urlString = [[NSMutableString alloc] initWithString:@"https:"];
    [urlString appendFormat:@"%@",url];
    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:urlString]];
    completion([UIImage imageWithData: data]);
}

- (NSString *)configureArticleLink:(NSString *)ID {
    return [NSString stringWithFormat:@"http://hubblesite.org/api/v3/news_release/%@", ID];
}

- (void)requestPassesWithLat:(NSString *)lat andLon:(NSString *)lon andCompliteon:(void (^)(NSArray<NSDictionary *> *))completion {
    NSMutableURLRequest *request = [self configurePassesGetRequestWithLat:lat andLon:lon];
    
    NSMutableArray *array = [NSMutableArray new];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
        } else {
            NSError *e = nil;
            NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
            
            for (NSDictionary *dict in [jsonArray objectForKey:@"response"]) {
                [array addObject:dict];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(array);
            });
        }
    }];
    
    [dataTask resume];
}

- (NSMutableURLRequest *)configurePassesGetRequestWithLat:(NSString *)lat andLon:(NSString *)lon {
    NSDictionary *headers = [self makeEmptyHeader];
    NSMutableURLRequest *request = [self makePassesGetRequestWithLat:lat andLon:lon];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    return request;
}

- (NSMutableURLRequest *)makePassesGetRequestWithLat:(NSString *)lat andLon:(NSString *)lon {
    
    NSString *link = [self configurePassesLinkWithLat:lat andLon:lon];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:link]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    return request;
}

- (NSString *)configurePassesLinkWithLat:(NSString*)lat andLon:(NSString *)lon {
    return [NSString stringWithFormat:@"http://api.open-notify.org/iss-pass.json?lat=%@&lon=%@", lat, lon];
}

- (void)requestIssPositionWithCompliteon:(void (^)(NSDictionary *))completion {
    NSMutableURLRequest *request = [self configureIssPositionGetRequest];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
        } else {
            NSError *e = nil;
            NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(jsonArray);
            });
        }
    }];
    
    [dataTask resume];
}

- (NSMutableURLRequest *)configureIssPositionGetRequest {
    NSDictionary *headers = [self makeEmptyHeader];
    NSMutableURLRequest *request = [self makeIssPositionGetRequest];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    return request;
}

- (NSMutableURLRequest *)makeIssPositionGetRequest {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://api.open-notify.org/iss-now.json"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    return request;
}


- (void)requestImageURLWithDateURL:(NSString *)url andCompliteon:(void (^)(NSString * _Nonnull))completion {
    NSMutableURLRequest *request = [self configureAPODGetRequest:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
        } else {
            NSError *e = nil;
            NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion([jsonArray objectForKey:@"url"]);
            });
        }
    }];
    
    [dataTask resume];
}

- (NSMutableURLRequest *)configureAPODGetRequest:(NSString *)url {
    NSMutableURLRequest *request = [self makeAPODGetRequest:url];
    [request setHTTPMethod:@"GET"];
    return request;
}

- (NSMutableURLRequest *)makeAPODGetRequest:(NSString *)url {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    return request;
}

- (void)requestImageWithDateURL:(NSString *)url andCompliteon:(void (^)(UIImage * _Nonnull))completion {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
        } else {
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
        }
    }];
    [dataTask resume];
}

@end
