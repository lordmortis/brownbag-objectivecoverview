	//
//  LCTimeTableView.m
//  LiveConiPhone
//
//  Created by Brendan Ragan on 25/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomDrawing.h"

void LCTimeTableViewDrawLine(CGContextRef context, CGPoint a, CGPoint b) {
	CGContextSaveGState(context);
	CGContextMoveToPoint(context, a.x, a.y);
	CGContextAddLineToPoint(context, b.x, b.y);
	CGContextStrokePath(context);
	CGContextRestoreGState(context);
}

void LCTimeTableViewDrawRoundRect(CGContextRef context, CGRect rect, CGFloat radius) {
	CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius, 3 * M_PI/2, M_PI, YES);
	CGContextMoveToPoint(context, rect.origin.x + radius, rect.origin.y);
	CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius, rect.origin.y);
	CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, radius, 3 * M_PI/2, 0, NO);
	CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - radius);
	CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height - radius, radius, 0, M_PI/2, NO);
	CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y + rect.size.height);
	CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius, radius, M_PI /2, M_PI, NO);
	CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + radius);
}

@end
