//
//  LCTimeTableView.h
//  LiveConiPhone
//
//  Created by Brendan Ragan on 25/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// Public header

struct LCTimeTableView {
	View *View
	void* displaySet;
	Convention *convention;
};

void LCTimeTableViewDrawLayerInContext:(Layer*)layer inContext:(GContext*)context


// Private Header

struct LCTimeTableView {
	View *View
	
	id <EventQuery>displaySet_;
	Convention *convention_;
	
	Date *start_;
	Date *end_;
	Array *venues_;
	Array *userEventIDs_;
	
	
	BOOL notify_;
	
	Color *column1Color_;
	Color *column2Color_;
	Color *boxColor_;
	Color *globalBoxColor_;
	Color *altBoxColor_;
	Color *textColor_;
	Color *globalTextColor_;
	Color *borderColor_;
	Color *timeLineColor_;
	Color *currentTimeLineColor_;
	
	Font *font_;
	Font *globalFont_;
	
	Float fontSize_;
	Float globalFontSize_;
	
	Float timeY_;
};

-(void)LCTimeTableViewEnableNotifications(LCTimeTableView* view);
-(void)LCTimeTableViewDisableNotifications(LCTimeTableView* view);
