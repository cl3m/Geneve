//
//  CommunesViewController.h
//  Genève
//
//  Created by Clem on 02.07.09.
//  Copyright 2009 ROUGE41. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <SafariServices/SafariServices.h>

@interface CommunesViewController : UITableViewController <UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate> {
	NSMutableArray *communes;
}


@property (nonatomic, retain) NSMutableArray *communes;

@end
