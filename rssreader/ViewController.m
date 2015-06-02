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
#import "ItemDetailViewController.h"
#import "CustomTVC.h"
#import <MBProgressHUD.h>

@interface ViewController ()

@property (nonatomic, strong) NSArray *tableData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize table data
    [self fetchItems];
    
    self.tableView.contentOffset = CGPointMake(0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchItems{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    ItemDAO *itemDAO = [[ItemDAO alloc] init];
    [itemDAO getAllItems:^(NSArray *items, NSError *serviceError) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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

#pragma TableView delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"customCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(CustomTVC *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    Item *item = [[Item alloc] init];
    item = [self.tableData objectAtIndex:indexPath.row];
    cell.titleLabel.text = item.title;
    if (item.imageLink) {
        NSURL *imgUrl = [[NSURL alloc] initWithString:item.imageLink];
        [cell.articleImageView setImageWithURL:imgUrl];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showItemDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"showItemDetail"])
    {
        NSIndexPath *cellIndexPath = [self.tableView indexPathForSelectedRow];
        ItemDetailViewController *itemDetailVC = segue.destinationViewController;
        itemDetailVC.item = [self.tableData objectAtIndex:cellIndexPath.row];
    }
}



@end
