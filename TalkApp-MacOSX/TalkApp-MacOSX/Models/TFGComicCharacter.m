//
//  TFGComicCharacter.m
//  TalkApp-MacOSX
//
//  Created by Brendan Ragan on 18/02/14.
//  Copyright (c) 2014 The Frontier Group. All rights reserved.
//

#import "TFGComicCharacter.h"

@implementation TFGComicCharacter

-(id)initWithFirstname:(NSString *)firstname
			  lastname:(NSString *)lastname
				   age:(int)age {
	self = [super init];
	if (self) {
		_firstname = firstname;
		_lastname = lastname;
		_age = age;
	}
	return self;
}

-(NSString*)name {
	if (_lastname && ([_lastname length] > 0))
		return [NSString stringWithFormat:@"%@ %@", _firstname, _lastname];
	else
		return [NSString stringWithFormat:@"%@", _firstname];
}

@end
