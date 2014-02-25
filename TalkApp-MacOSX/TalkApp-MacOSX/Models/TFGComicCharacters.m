//
//  TFGComicCharacters.m
//  TalkApp-MacOSX
//
//  Created by Brendan Ragan on 25/02/14.
//  Copyright (c) 2014 The Frontier Group. All rights reserved.
//

#import "TFGComicCharacters.h"

@implementation TFGComicCharacters

-(id)init {
	self = [super init];
	if (self) {
		_characters = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void)addComicCharacter:(TFGComicCharacter *)character	{
	[_characters addObject:character];
}

-(void)addComicCharacterWithFirstname:(NSString *)firstname
							 lastname:(NSString *)lastname
								  age:(int)age	{
	TFGComicCharacter *character;
	character = [[TFGComicCharacter alloc] initWithFirstname:firstname
													lastname:lastname
														 age:age];
	[_characters addObject:character];
}

@end
