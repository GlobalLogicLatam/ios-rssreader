//
//  ItemDetailViewController.h
//  rssreader
//
//  Created by Gerson Villanueva on 5/31/15.
//  Copyright (c) 2015 Gerson Villanueva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface ItemDetailViewController : UIViewController

@property(nonatomic, strong) Item *item;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

@end
