//
//  ItemDAO.h
//  rssreader
//
//  Created by Gerson Villanueva on 5/30/15.
//  Copyright (c) 2015 Gerson Villanueva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemDAO : NSObject

@property (copy, nonatomic) void(^ completion)(NSArray * result, NSError * error);
@property (copy, nonatomic) void(^ failure)(ItemDAO * serv, NSError * error);

- (void)getAllItems:(void (^)(NSArray *items, NSError *serviceError))completion;


@end
