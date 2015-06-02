//
//  ItemDetailViewController.m
//  rssreader
//
//  Created by Gerson Villanueva on 5/31/15.
//  Copyright (c) 2015 Gerson Villanueva. All rights reserved.
//

#import "ItemDetailViewController.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.item.title;
    [self.contentWebView loadHTMLString:self.item.content baseURL:nil];
}


@end
