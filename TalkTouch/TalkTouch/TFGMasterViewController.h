//
//  TFGMasterViewController.h
//  TalkTouch
//
//  Created by Brendan Ragan on 26/02/14.
//  Copyright (c) 2014 Frontier Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFGDetailViewController;

@interface TFGMasterViewController : UITableViewController

@property (strong, nonatomic) TFGDetailViewController *detailViewController;

@end
