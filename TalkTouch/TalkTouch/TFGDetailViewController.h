//
//  TFGDetailViewController.h
//  TalkTouch
//
//  Created by Brendan Ragan on 26/02/14.
//  Copyright (c) 2014 Frontier Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../TalkApp-MacOSX/TalkLib/TFGComicCharacter.h"

@interface TFGDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) TFGComicCharacter	*character;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
