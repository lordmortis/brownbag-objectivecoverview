//
//  TFGCharactersViewController.m
//  TalkApp-MacOSX
//
//  Created by Brendan Ragan on 25/02/14.
//  Copyright (c) 2014 The Frontier Group. All rights reserved.
//

#import "TFGCharactersViewController.h"

@interface TFGCharactersViewController ()

@end

@implementation TFGCharactersViewController

- (void)awakeFromNib {
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

	[_characterWindow setReleasedWhenClosed:false];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	return [_characters count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	TFGComicCharacter *character = [_characters objectAtIndex: row];
	if (tableColumn == [tableView.tableColumns objectAtIndex:0])
		return character.name;
	else
		return [NSString stringWithFormat:@"%i", character.age];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
	NSInteger row = _tableView.selectedRow;
	if (row > -1) {
		TFGComicCharacter *character = [_characters objectAtIndex:row];
		[_name setStringValue:character.name];
		[_age setIntegerValue:character.age];
		[_characterWindow makeKeyAndOrderFront:self];
	} else {
		[_characterWindow close];
	}
}

@end
