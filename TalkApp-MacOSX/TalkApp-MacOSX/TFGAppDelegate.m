//
//  TFGAppDelegate.m
//  TalkApp-MacOSX
//
//  Created by Brendan Ragan on 18/02/14.
//  Copyright (c) 2014 The Frontier Group. All rights reserved.
//

#import "TFGAppDelegate.h"
#import "TFGComicCharacter.h"

@implementation TFGAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
	
	TFGComicCharacter *character = 	[[TFGComicCharacter alloc] initWithFirstname:@"Reed"
																	    lastname:@"Richards"
																		 	 age:56];
	
	NSLog(@"Character: %@", character);
}

@end
