//
//  TFGCharactersViewController.h
//  TalkApp-MacOSX
//
//  Created by Brendan Ragan on 25/02/14.
//  Copyright (c) 2014 The Frontier Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TFGComicCharacters.h"

@interface TFGCharactersViewController : NSViewController <NSTableViewDataSource>

@property (nonatomic, strong) TFGComicCharacters* characters;



@end
