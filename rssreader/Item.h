//
//  Item.h
//  rssreader
//
//  Created by Gerson Villanueva on 5/30/15.
//  Copyright (c) 2015 Gerson Villanueva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *itemDescription;
@property(nonatomic, strong) NSString *content;
@property(nonatomic, strong) NSString *imageLink;

@end
