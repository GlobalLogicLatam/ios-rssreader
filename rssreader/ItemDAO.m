//
//  ItemDAO.m
//  rssreader
//
//  Created by Gerson Villanueva on 5/30/15.
//  Copyright (c) 2015 Gerson Villanueva. All rights reserved.
//

#import "ItemDAO.h"
#import "ItemService.h"
#import "Item.h"

static NSString * const kItemElementName = @"item";
static NSString * const kTitleElementName = @"title";
static NSString * const kDescriptionElementName = @"description";
static NSString * const kContentElementName = @"content:encoded";
static NSString * const kImageElementName = @"media:thumbnail";

@interface ItemDAO () <NSXMLParserDelegate>

@property (nonatomic) NSMutableArray *itemsDAO;
@property (nonatomic, strong) Item *item;
@property(nonatomic, strong) NSString *elementName;
@property(nonatomic, strong) NSMutableString *outstring;

@end

@implementation ItemDAO

- (void)getAllItems:(void (^)(NSArray *items, NSError *serviceError))completion{
    
    ItemService *webService = [[ItemService alloc] init];
    
    [webService fetchItemsCompletion:^(NSData *result, NSError *error) {
        [self initXMLParserWithData:result];
        completion(self.itemsDAO, error);
    }];
}

- (void)initXMLParserWithData:(NSData*)data{
    self.itemsDAO = [[NSMutableArray alloc] init];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setShouldProcessNamespaces:YES];
    [parser setDelegate:self];
    [parser parse];
}

#pragma mark - NSXMLParser delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    self.elementName = qName;
    if([qName isEqualToString:@"item"]){
        if(self.item)
            [self.itemsDAO addObject:self.item];
        self.item = [[Item alloc] init];
    }
    if([qName isEqualToString:kImageElementName]){
        self.item.imageLink = [attributeDict objectForKey:@"url"];
    }
    self.outstring = [NSMutableString string];
}



- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!self.elementName)
        return;
    
    [self.outstring appendFormat:@"%@", string];
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([qName isEqualToString:kTitleElementName]) {
        self.item.title = self.outstring;
    }
    if ([qName isEqualToString:kDescriptionElementName]) {
        self.item.itemDescription = self.outstring;
    }
    if ([qName isEqualToString:kContentElementName]) {
        self.item.content = self.outstring;
    }
    self.elementName = nil;
}


@end
