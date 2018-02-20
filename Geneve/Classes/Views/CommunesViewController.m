//
//  CommunesViewController.m
//  Genève
//
//  Created by Clem on 02.07.09.
//  Copyright 2009 ROUGE41. All rights reserved.
//

#import "CommunesViewController.h"
#import "Commune.h"

sqlite3 *database;


@implementation CommunesViewController

@synthesize communes;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	communes = [[NSMutableArray alloc] init];
    
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"communes.sqlite"];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *statement;
		//update from v1 to v2
		const char *sql = "SELECT name,armoirie,url,postcode FROM communes ORDER BY [order]";
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char *str = (char *)sqlite3_column_text(statement, 0);
				char *str2 = (char *)sqlite3_column_text(statement, 2);
				char *str3 = (char *)sqlite3_column_text(statement, 3);
				NSData *dataForImage = [[[NSData alloc] initWithBytes:sqlite3_column_blob(statement, 1) length: sqlite3_column_bytes(statement, 1)] autorelease];           
				Commune *c = [[Commune alloc] initWithNameUrlPostcodeAndArmoirie:[NSString stringWithUTF8String:str] url:[NSString stringWithUTF8String:str2] postcode:[NSString stringWithUTF8String:str3] armoirie:[UIImage imageWithData:dataForImage]];
				[communes addObject:c];
				[c release];
            }
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
        NSLog(@"Error open DB");
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    [super viewWillAppear:animated];
    
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:self.title];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return communes.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"communeCell"];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"communeCell"] autorelease];
		
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
		
		cell.detailTextLabel.backgroundColor = [UIColor clearColor];
		cell.detailTextLabel.opaque = NO;
		cell.detailTextLabel.textColor = [UIColor grayColor];
		cell.detailTextLabel.highlightedTextColor = [UIColor whiteColor];
		cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
		
	}
	Commune *c = [communes objectAtIndex:indexPath.row];
	
	cell.textLabel.text = c.name;
	cell.detailTextLabel.text = c.postcode;
    cell.imageView.image = c.armoirie;
    cell.imageView.contentMode = UIViewContentModeCenter;
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    Commune *commune = [communes objectAtIndex:indexPath.row];
    SFSafariViewController *viewController = [[SFSafariViewController alloc] initWithURL:[[NSURL alloc] initWithString:commune.url]];
    viewController.delegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)dealloc {
	sqlite3_close(database);
	[communes release];
	[super dealloc];
}


@end
