//
//  ItemService.m
//  rssreader
//
//  Created by Gerson Villanueva on 5/30/15.
//  Copyright (c) 2015 Gerson Villanueva. All rights reserved.
//

#import "ItemService.h"
#import "AFNetworking.h"

NSString *const kServiveUrl = @"http://club.globallogic.com.ar/feed/";

@implementation ItemService

- (NSData *)getRequest:(NSString*)path
{
    NSURL *url = [NSURL URLWithString:path];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    //Setting header
    // Using AFXMLParserResponseSerializer only for xml request
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/rss+xml"];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.data = operation.responseData;
        self.completion(self.data, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.failure(self, error);
    }];
    return self.data;
}

- (void)fetchItemsCompletion:(void(^)(NSData * result, NSError * error))completion :(void(^)(ItemService * serv, NSError * error)) failure{
    self.completion = completion;
    self.failure = failure;
    [self getRequest:kServiveUrl];
}

@end