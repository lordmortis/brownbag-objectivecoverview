//
//  TFGMasterViewController.m
//  TalkTouch
//
//  Created by Brendan Ragan on 26/02/14.
//  Copyright (c) 2014 Frontier Group. All rights reserved.
//

#import "TFGMasterViewController.h"
#import "TFGDetailViewController.h"
#import "../../TalkApp-MacOSX/TalkLib/TFGComicCharacters.h"

@interface TFGMasterViewController () {
	TFGComicCharacters *_characters;
}
@end

@implementation TFGMasterViewController

- (void)awakeFromNib
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
	    self.clearsSelectionOnViewWillAppear = NO;
	    self.preferredContentSize = CGSizeMake(320.0, 600.0);
	}
	_characters = [[TFGComicCharacters alloc] init];

	[_characters addComicCharacterWithFirstname:@"Reed"
									   lastname:@"Richards"
											age:56];
	
	[_characters addComicCharacterWithFirstname:@"Tony"
									   lastname:@"Stark"
											age:45];
	
	[_characters addComicCharacterWithFirstname:@"Steve"
									   lastname:@"Rogers"
											age:80];
	
	[_characters addComicCharacterWithFirstname:@"Thor"
									   lastname:nil
											age:999];
	
	[_characters addComicCharacterWithFirstname:@"Natasha"
									   lastname:@"Romanov"
											age:-1];
    
	[super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.navigationItem.leftBarButtonItem = self.editButtonItem;

	self.detailViewController = (TFGDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_characters count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

	TFGComicCharacter *character = [_characters objectAtIndex:indexPath.row];
	cell.textLabel.text = [character name];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        NSDate *object = _objects[indexPath.row];
//        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = _objects[indexPath.row];
//        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
