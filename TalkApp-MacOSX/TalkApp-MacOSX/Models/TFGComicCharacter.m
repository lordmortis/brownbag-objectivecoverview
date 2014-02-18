//
//  TFGComicCharacter.m
//  TalkApp-MacOSX
//
//  Created by Brendan Ragan on 18/02/14.
//  Copyright (c) 2014 The Frontier Group. All rights reserved.
//

#import "TFGComicCharacter.h"

@implementation TFGComicCharacter

-(NSString*)name {
	if (_lastname && ([_lastname length] > 0))
		return [NSString stringWithFormat:@"%@ %@", _firstname, _lastname];
	else
		return [NSString stringWithFormat:@"%@", _firstname];
}

@end
