//
//  LiensViewController.h
//  Genève
//
//  Created by Clem on 02.07.09.
//  Copyright ROUGE41 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <SafariServices/SafariServices.h>

@interface LiensViewController : UITableViewController <UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate>  {
	NSMutableArray *liens;
}

@property (nonatomic, retain) NSMutableArray *liens;

@end
