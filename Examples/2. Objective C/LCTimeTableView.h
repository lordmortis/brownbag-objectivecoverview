//
//  LCTimeTableView.h
//  LiveConiPhone
//
//  Created by Brendan Ragan on 25/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventQueryProtocol.h"

@class Convention;
@interface LCTimeTableView : UIView <UIScrollViewDelegate>{

@private
	id <EventQuery>displaySet_;
	Convention *convention_;
	
	NSDate *start_;
	NSDate *end_;
	NSArray *venues_;
	NSArray *userEventIDs_;
	
	
	BOOL notify_;
	
	UIColor *column1Color_;
	UIColor *column2Color_;
	UIColor *boxColor_;
	UIColor *globalBoxColor_;
	UIColor *altBoxColor_;
	UIColor *textColor_;
	UIColor *globalTextColor_;	
	UIColor *borderColor_;
	UIColor *timeLineColor_;
	UIColor *currentTimeLineColor_;
	
	UIFont *font_;
	UIFont *globalFont_;
	
	CGFloat fontSize_;
	CGFloat globalFontSize_;
	
	CGFloat timeY_;	
}

-(void)enableNotifications;
-(void)disableNotifications;

@property (nonatomic, assign) id<EventQuery> displaySet;
@property (nonatomic, assign) Convention *convention;

@end
