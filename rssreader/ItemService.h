//
//  ItemService.h
//  rssreader
//
//  Created by Gerson Villanueva on 5/30/15.
//  Copyright (c) 2015 Gerson Villanueva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemService : NSObject

@property (strong, nonatomic) NSData *data;
@property (strong, nonatomic) NSString *url;
@property (copy, nonatomic) void(^ completion)(NSData * result, NSError * error);
@property (copy, nonatomic) void(^ failure)(ItemService * serv, NSError * error);

- (void)fetchItemsCompletion:(void(^)(NSData * result, NSError * error))completion :(void(^)(ItemService * serv, NSError * error)) failure;

@end
