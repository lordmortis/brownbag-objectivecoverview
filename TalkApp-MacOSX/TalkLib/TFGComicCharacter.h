//
//  TFGComicCharacter.h
//  TalkApp-MacOSX
//
//  Created by Brendan Ragan on 18/02/14.
//  Copyright (c) 2014 The Frontier Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFGComicCharacter : NSObject

@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *lastname;
@property (nonatomic) int age;

@property (nonatomic, readonly) NSString *name;

-(id)initWithFirstname:(NSString*)firstname
			  lastname:(NSString*)lastname
				   age:(int)age;

@end
