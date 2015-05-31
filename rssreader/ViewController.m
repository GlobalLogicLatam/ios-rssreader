//
//  ViewController.m
//  rssreader
//
//  Created by Gerson Villanueva on 5/26/15.
//  Copyright (c) 2015 Gerson Villanueva. All rights reserved.
//

#import "ViewController.h"
#import "ItemDAO.h"
#import "UIImageView+AFNetworking.h"
#import "Item.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *tableData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize table data
    [self fetchItems];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Item *item = [[Item alloc] init];
    item = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    if (item.imageLink) {
        NSURL *imgUrl = [[NSURL alloc] initWithString:item.imageLink];
        [cell.imageView setImageWithURL:imgUrl];
    }
    return cell;
}

- (void)fetchItems{
    ItemDAO *itemDAO = [[ItemDAO alloc] init];
    [itemDAO getAllItems:^(NSArray *items, NSError *serviceError) {
        if (serviceError) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Items"
                                                                message:[serviceError localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }else{
            self.tableData = items;
            [self.tableView reloadData];
        }
    }];
}

@end
