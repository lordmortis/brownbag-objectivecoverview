//
//  TFGComicCharacters.h
//  TalkApp-MacOSX
//
//  Created by Brendan Ragan on 25/02/14.
//  Copyright (c) 2014 The Frontier Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFGComicCharacter.h"

@interface TFGComicCharacters : NSObject

@property (nonatomic, readonly) NSMutableArray *characters;

-(void)addComicCharacter:(TFGComicCharacter*)character;

-(void)addComicCharacterWithFirstname:(NSString*)firstname
							 lastname:(NSString*)lastname
								  age:(int)age;

-(NSInteger) count;

-(TFGComicCharacter*)objectAtIndex:(NSInteger)index;

@end
