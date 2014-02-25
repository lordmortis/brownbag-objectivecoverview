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

@end
