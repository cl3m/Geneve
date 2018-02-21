//
//  LiensViewController.m
//  Genève
//
//  Created by Clem on 02.07.09.
//  Copyright ROUGE41 2009. All rights reserved.
//

#import "LiensViewController.h"
#import "Lien.h"
#import "LienCell.h"


sqlite3 *database2;

@implementation LiensViewController

@synthesize liens;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	liens = [[NSMutableArray alloc] init];
	
	NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"liens.sqlite"];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database2) == SQLITE_OK) {
        sqlite3_stmt *statement;
		//update from v1 to v2
		const char *sql = "SELECT name,logo,url FROM liens ORDER BY `order`";
        if (sqlite3_prepare_v2(database2, sql, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char *str = (char *)sqlite3_column_text(statement, 0);
				char *str2 = (char *)sqlite3_column_text(statement, 2);
				NSData *dataForImage = [[[NSData alloc] initWithBytes:sqlite3_column_blob(statement, 1) length: sqlite3_column_bytes(statement, 1)] autorelease];           
				Lien *l = [[Lien alloc] initWithNameUrlAndLogo:[NSString stringWithUTF8String:str] url:[NSString stringWithUTF8String:str2] logo:[UIImage imageWithData:dataForImage]];
				[liens addObject:l];
				[l release];
            }
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
		NSLog(@"Error open DB");
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return liens.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	LienCell *cell = (LienCell*)[self.tableView dequeueReusableCellWithIdentifier:@"LienCell"];
	
	Lien *l = [liens objectAtIndex:indexPath.row];
	
	if (cell == nil) {
		cell = [[[LienCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"LienCell"] autorelease];
		
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		cell.textLabel.font = [UIFont systemFontOfSize:17.0];
		
		cell.image = [[UIImageView alloc] initWithImage:l.logo];
		[cell addSubview:cell.image];
		CGRect frame = [cell.image frame];
		float ratio = frame.size.height/frame.size.width;
		frame.origin.y = 3;
		frame.origin.x = 3;
		frame.size.height = cell.frame.size.height-6;
		frame.size.width = frame.size.height/ratio;
		cell.image.frame = frame;
		
	}
	
	cell.textLabel.text = [NSString stringWithFormat:@"              %@", l.name];
	//cell.detailTextLabel.text = c.postcode;
	
	
	cell.image.image = l.logo;
	
	
	//sqlite3_finalize(statement);
	return cell;	
}

- (void)viewWillAppear:(BOOL)animated {
	[self.tableView reloadData];
	[super viewWillAppear:animated];
    
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value: @"Liens"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    Lien *lien = [liens objectAtIndex:indexPath.row];
    SFSafariViewController *viewController = [[SFSafariViewController alloc] initWithURL:[[NSURL alloc] initWithString:lien.url]];
    viewController.delegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)dealloc {
	[liens release];
	sqlite3_close(database2);
	[super dealloc];
}

@end
