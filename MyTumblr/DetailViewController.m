//
//  DetailViewController.m
//  MyTumblr
//
//  Created by Jakub Kaliszyk on 19.12.2015.
//  Copyright © 2015 Jakub Kaliszyk. All rights reserved.
//

#import "DetailViewController.h"
#import "TumblrAPIController.h"

@interface DetailViewController () {
    NSMutableArray *posts;
}

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    self.view.backgroundColor = [UIColor darkGrayColor];

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"user"] description];
    }
    if (self)
        self.title = [[self.detailItem valueForKey:@"user"] description];
    //get (photo) posts
    posts = [TumblrAPIController tumblrUserPhotoPosts:[[self.detailItem valueForKey:@"user"]description]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    //get summary and url from array
    NSDictionary *summaryUrl = [posts objectAtIndex:indexPath.row];
    NSString *url = [summaryUrl objectForKey:@"url"];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    //make image from url
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:4];
    imageView.image = [UIImage imageWithData:data];
    //and text from summary
    NSString *summary = [summaryUrl objectForKey:@"summary"] ;
    UITextView *textView = (UITextView*)[cell viewWithTag:5];
    textView.text = summary;
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // for inset to be width-full
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
