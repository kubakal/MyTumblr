//
//  DetailViewController.h
//  MyTumblr
//
//  Created by Jakub Kaliszyk on 19.12.2015.
//  Copyright © 2015 Jakub Kaliszyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

