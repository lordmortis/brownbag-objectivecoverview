	//
//  LCTimeTableView.m
//  LiveConiPhone
//
//  Created by Brendan Ragan on 25/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LCTimeTableView.h"

#import "LCConventionDisplay.h"

#import "DataManager.h"
#import "CustomDrawing.h"

#import "Convention.h"
#import "FilterSet.h"
#import "Event.h"
#import "Venue.h"

@implementation LCTimeTableView

@synthesize convention = convention_;

+ (Class)layerClass {
	return [CATiledLayer class];
}

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

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		self.opaque = YES;
		notify_ = true;
		fontSize_ = 12.0;
		globalFontSize_ = 25;
		font_ = [[UIFont fontWithName:@"Helvetica-Bold" size:fontSize_] retain];
		globalFont_ = [[UIFont fontWithName:@"Helvetica-Bold" size:globalFontSize_] retain];
		column1Color_ = [[UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f] retain];
		column2Color_ = [[UIColor colorWithRed:0.267f green:0.384f blue:0.643f alpha:1.0f] retain];
		boxColor_ = [[UIColor colorWithRed:0.608f green:0.745f blue:0.992f alpha:1.0f] retain];
		altBoxColor_ = [[UIColor colorWithRed:0.408f green:0.545f blue:0.792f alpha:1.0f] retain];
		globalBoxColor_ = [[UIColor colorWithRed:0.608f green:0.745f blue:0.882f alpha:0.4f] retain]; 
		textColor_ = [[UIColor blackColor] retain];
		globalTextColor_ = [[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.4f] retain]; 
		borderColor_ = [[UIColor blackColor] retain];
		timeLineColor_ = [[UIColor colorWithRed:0.40f green:0.506f blue:0.714f alpha:1.0f] retain];		
		currentTimeLineColor_ = [[UIColor colorWithRed:1.0f green:0.16f blue:0.16f alpha:0.25] retain];
    }
    return self;
}

-(id<EventQuery>)displaySet {
	return displaySet_;
}

-(void)setDisplaySet:(id<EventQuery>)displaySet	{
	displaySet_ = displaySet;
	if (displaySet == nil)
		return;
	
	if (start_ != nil)
		[start_ release];
	start_ = [[displaySet sessionsConvention].start_time retain];
	if (end_ != nil)
		[end_ release];
	end_ = [[displaySet sessionsConvention].end_time retain];
	
	if (venues_ != nil)
		[venues_ release];
	venues_ = [[displaySet venueArray] retain];
}

-(void)drawRect:(CGRect)rect {
    // UIView uses the existence of -drawRect: to determine if should allow its CALayer
    // to be invalidated, which would then lead to the layer creating a backing store and
    // -drawLayer:inContext: being called.
    // By implementing an empty -drawRect: method, we allow UIKit to continue to implement
    // this logic, while doing our real drawing work inside of -drawLayer:inContext:
}

- (void)drawLayer:(CALayer*)layer inContext:(CGContextRef)context {
	CGRect box = CGContextGetClipBoundingBox(context);
	// FIXME: THIS IS A FUCKING HUGE HACK. I NEED TO FIND OUT WHY THE FUCK THIS IS BEING 
	// CALLED WHEN IT SHOULDNT
	if (box.size.height < 1.0f)
		return;
	
	CGRect drawRect1, drawRect2;
	CGPoint point1, point2;
	UIColor *drawColor1;

	
	// Step 1, draw Columns.	
	CGFloat widthSubDivisions = floorf(box.origin.x / LCUITimeTableVenueWidth);
	drawRect1.origin.y = box.origin.y;
	drawRect1.size.height = box.size.height;
	drawRect1.size.width = LCUITimeTableVenueWidth;
	drawRect1.origin.x = widthSubDivisions * LCUITimeTableVenueWidth;

	CGContextSetLineWidth(context, 2.0f);
	CGContextSetStrokeColorWithColor(context, [borderColor_ CGColor]);
	
	if (drawRect1.origin.x < 1.0f) {
		drawRect1.origin.x = 2.0f;
		point1 = CGPointMake(4.0f, drawRect1.origin.y);
		point2 = point1;
		point2.y += drawRect1.size.height;
		LCTimeTableViewDrawLine(context, point1, point2);
	}
	

	int venueIndex = widthSubDivisions;
	int startVenueIndex = venueIndex;
	
	if (startVenueIndex >= [venues_ count]) 
		return;
	
	do {
		if (venueIndex % 2 == 0) 
			drawColor1 = column1Color_;
		else
			drawColor1 = column2Color_;
		
		CGContextSetFillColorWithColor(context, [drawColor1	CGColor]);
		CGContextFillRect(context, drawRect1);
		
		point1 = CGPointMake(drawRect1.origin.x + drawRect1.size.width,
							 drawRect1.origin.y);
		point2 = point1;
		point2.y += drawRect1.size.height;
		LCTimeTableViewDrawLine(context, point1, point2);
		
		venueIndex += 1;
		drawRect1.origin.x += LCUITimeTableVenueWidth;
	} while (drawRect1.origin.x < (box.origin.x + box.size.width));
	
	int endVenueIndex = venueIndex;
		
	// Step 2 draw time lines
	point1.x = box.origin.x;
	if (point1.x < 1.0f)
		point1.x = 2.0f;
	CGFloat heightSubdivisions = floorf(box.origin.y / (LCUITimeTableTimeHeight / 2.0));
	point1.y = heightSubdivisions * (LCUITimeTableTimeHeight / 2.0);
	
	CGFloat startTime = point1.y / LCUITimeTableTimeHeight;
	
	CGContextSetLineWidth(context, 1.0f);
	CGContextSetStrokeColorWithColor(context, [timeLineColor_ CGColor]);
	do {
		point2 = point1;
		point2.x = box.origin.x + box.size.width;
		LCTimeTableViewDrawLine(context, point1, point2);
		point1.y += LCUITimeTableTimeHeight / 2.0f;
	} while (point1.y < (box.origin.y + box.size.height));
	
	CGFloat endTime = (point1.y / LCUITimeTableTimeHeight);
	// Step 3 - draw Events
	// NSArray *events;
	// 3a Grab all the venues
	NSRange venueRange;
	venueRange.location = startVenueIndex;
	venueRange.length = endVenueIndex - startVenueIndex;
	NSArray *venues = [[venues_ subarrayWithRange:venueRange] valueForKey:@"objectID"];

	// 3b Grab the enclosing times
	NSDate *start, *end;
	start = [start_ dateByAddingTimeInterval:startTime * 3600.0f];
	end = [start_ dateByAddingTimeInterval:endTime * 3600.0f];

	// 3c grab events and draw 'em
	CGContextSetStrokeColorWithColor(context, [textColor_ CGColor]);
	
	CTFontRef ctfont = CTFontCreateWithName((CFStringRef)font_.fontName,
											fontSize_, NULL);
	
	CTFontRef globalfont = CTFontCreateWithName((CFStringRef)globalFont_.fontName,
												globalFontSize_, NULL);

	CTTextAlignment ctAlignment = kCTCenterTextAlignment;

	CTParagraphStyleSetting theSettings[1] = {
		{ kCTParagraphStyleSpecifierAlignment, sizeof(CTTextAlignment),
			&ctAlignment }
	};
	CTParagraphStyleRef ctstyle = CTParagraphStyleCreate(theSettings, 1);
	
	NSDictionary *attributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
									(id)ctfont, (id)kCTFontAttributeName,
									[textColor_ CGColor], (id)kCTForegroundColorAttributeName,
									(id)ctstyle, (id)kCTParagraphStyleAttributeName,
									nil];

	NSDictionary *globalAttributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
									(id)globalfont, (id)kCTFontAttributeName,
									[globalTextColor_ CGColor], (id)kCTForegroundColorAttributeName,
									(id)ctstyle, (id)kCTParagraphStyleAttributeName,
									nil];
	
	
	CGMutablePathRef pathRef;
	NSAttributedString *drawString;
	
	// Draw Global Events
	NSArray *events = [displaySet_ globalSessionsBetweenTime:start andTime:end];
	for (Event *event in events) {
		CGContextSaveGState(context);
		drawRect1.origin.y = ([event.starts timeIntervalSinceDate:start_] / 3600.0f) * LCUITimeTableTimeHeight;
		drawRect1.size.height = ([event.ends timeIntervalSinceDate:event.starts] / 3600.0f) * LCUITimeTableTimeHeight;
		drawRect1.size.width = LCUITimeTableVenueWidth * [venues_ count];
		drawRect1.origin.x = 0;
		
		CGContextSetFillColorWithColor(context, [globalBoxColor_ CGColor]);
		
		
				
		drawRect2 = CGRectInset(drawRect1, 2.0f, 2.0f);
		
		LCTimeTableViewDrawRoundRect(context, drawRect2, 5.0f);
		CGContextDrawPath(context, kCGPathFill);

		LCTimeTableViewDrawRoundRect(context, drawRect2, 5.0f);	
		CGContextClip(context);
	
		
		drawString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",event.name]
													 attributes:globalAttributesDict];

		CGContextSetTextMatrix(context, CGAffineTransformIdentity);

		CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)drawString);
		CGSize lineSize = LCCustomDrawingCTLineHeight(line);

		CGAffineTransform rotation = CGAffineTransformIdentity;
		rotation = CGAffineTransformTranslate(rotation, -lineSize.width / 2.0f, -lineSize.height/2.0f);
		rotation = CGAffineTransformRotate(rotation, M_PI_4);
		rotation = CGAffineTransformScale(rotation, 1, -1);
		
		CGContextTranslateCTM(context, 0, drawRect1.origin.y);
		
		CGFloat ypos = 0;
		while (ypos < (drawRect1.size.height + lineSize.width)) {
			CGContextSaveGState(context);
			CGContextTranslateCTM(context, 0, ypos);

			CGFloat xpos = -lineSize.height;
			while (xpos < (drawRect1.size.width + lineSize.height)) {
				CGContextSaveGState(context);			
				
				CGContextTranslateCTM(context, xpos, 0);
				CGContextConcatCTM(context, rotation);
				CGContextSetTextMatrix(context, CGAffineTransformIdentity);
				CTLineDraw(line, context);
				
				xpos += lineSize.height + 10.0f;
				CGContextRestoreGState(context);
			}
			
			ypos += lineSize.width * 0.8;
			CGContextRestoreGState(context);
		}

		CFRelease(line); 	
		
		[drawString release];		
		
		CGContextRestoreGState(context);
	}
	
	events = [displaySet_ sessionsBetweenTime:start andTime:end withVenues:venues];
	for (Event *event in events) {
		drawRect1.origin.y = ([event.starts timeIntervalSinceDate:start_] / 3600.0f) * LCUITimeTableTimeHeight;
		drawRect1.size.height = ([event.ends timeIntervalSinceDate:event.starts] / 3600.0f) * LCUITimeTableTimeHeight;
		drawRect1.size.width = LCUITimeTableVenueWidth;

		if (displaySet_ == convention_.usersProgramme) 
			CGContextSetFillColorWithColor(context, [boxColor_ CGColor]);
		else {
			if ([userEventIDs_ containsObject:event.objectID]) 
				CGContextSetFillColorWithColor(context, [altBoxColor_ CGColor]);
			else
				CGContextSetFillColorWithColor(context, [boxColor_ CGColor]);
		}		
		
		for (Venue* venue in event.venues) {
			
			venueIndex = [venues indexOfObject:venue.objectID];
			if (venueIndex != NSNotFound) {
				CGContextSaveGState(context);
				CGContextSetTextMatrix(context, CGAffineTransformIdentity);
				drawRect1.origin.x = (startVenueIndex * LCUITimeTableVenueWidth) +
					venueIndex * LCUITimeTableVenueWidth;
				
				drawRect2 = CGRectInset(drawRect1, 2.0f, 2.0f);
				
				LCTimeTableViewDrawRoundRect(context, drawRect2, 5.0f);
				CGContextDrawPath(context, kCGPathFillStroke);

				if (([event.name length] > 0) && (drawRect2.size.height > 0)) {
					pathRef = CGPathCreateMutable();
					drawString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",event.name]
																 attributes:attributesDict];
					
					CTFramesetterRef framesetter = 
					CTFramesetterCreateWithAttributedString((CFAttributedStringRef)drawString);
				
					drawRect2 = CGRectInset(drawRect1, 4.0f, 4.0f);
					drawRect2.origin.y = 0 - drawRect2.origin.y;
					drawRect2.size.height = 0 - drawRect2.size.height;
				
					CGContextScaleCTM(context, 1, -1);
					CGPathAddRect(pathRef, NULL, drawRect2);	
					CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
																CFRangeMake(0, 0), pathRef, NULL);
					
					CGFloat height = LCCustomDrawingCTFrameHeight(frame, drawRect2.size);
					CGPathRelease(pathRef);
				
					pathRef = CGPathCreateMutable();
					drawRect2.origin.y = 0 - (drawRect1.origin.y + (drawRect1.size.height / 2.0f - height / 2.0f));
					drawRect2.size.height = 0 - height;
					
					CGPathAddRect(pathRef, NULL, drawRect2);
					
					
					frame = CTFramesetterCreateFrame(framesetter,
													 CFRangeMake(0, 0), pathRef, NULL);

					CGPathRelease(pathRef);
					CFRelease(framesetter);
					CTFrameDraw(frame, context);
					
					[drawString release];
				}
				CGContextRestoreGState(context);
			}
		}
	}

	// Draw a line across the schedule if required
	CGFloat startY = box.origin.y - 6.0f;
	CGFloat endY = box.origin.y + box.size.height + 6.0f;
	
	if ((timeY_ > startY) && (timeY_ < endY)) {
		CGContextSetLineWidth(context, 20.0f);
		CGContextSetStrokeColorWithColor(context, [currentTimeLineColor_ CGColor]);
		CGContextMoveToPoint(context, box.origin.x, timeY_ + 10.0f);
		CGContextAddLineToPoint(context, box.origin.x + box.size.width, timeY_ + 10.0f);
		CGContextStrokePath(context);
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint touchPoint = [touch locationInView:self];
	
	if ((touchPoint.x > self.frame.size.width) || (touchPoint.x < 0))
		return;

	if ((touchPoint.y > self.frame.size.height) || (touchPoint.y < 0))
		return;	
	
	NSDate *touchTime = [start_ dateByAddingTimeInterval:(touchPoint.y / LCUITimeTableTimeHeight) * 3600.0f];
	NSUInteger venueIndex = ((int)floorf(touchPoint.x / LCUITimeTableVenueWidth));
	Venue *touchVenue = [venues_ objectAtIndex:venueIndex];
	
	if ((touchTime == nil) || (touchVenue == nil)) {
		NSLog(@"Touch had an invalid time or venue?");
		return;
	}
	
	Event *session = [displaySet_ sessionAttime:touchTime inVenue:touchVenue];
	if (session == nil)
		return;
	
	CGRect sessionRect;
	sessionRect.origin.y = [session.starts timeIntervalSinceDate:start_] / 3600.0f;
	sessionRect.origin.y = sessionRect.origin.y * LCUITimeTableTimeHeight;
	sessionRect.origin.x = LCUITimeTableVenueWidth * venueIndex;
	sessionRect.size.width = LCUITimeTableVenueWidth;
	sessionRect.size.height = [session.ends timeIntervalSinceDate:session.starts] / 3600.0f;
	sessionRect.size.height = sessionRect.size.height * LCUITimeTableTimeHeight;
	
	NSValue *sessionRectObject = [NSValue valueWithCGRect:sessionRect];
	
	NSDictionary *object = [NSDictionary dictionaryWithObjectsAndKeys:session, @"session", 
							sessionRectObject, @"rect",nil];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:LCUISessionSelected object:object];
}

-(void)setNeedsLayout {
	CATiledLayer *layer = (CATiledLayer*)self.layer;
	layer.tileSize = CGSizeMake(512.0f, 512.0f);

	NSDate *now = [NSDate date];
	if (([now compare:convention_.start_time] == NSOrderedDescending) && 
		([now compare:convention_.end_time] == NSOrderedAscending)) {
		timeY_ = [now timeIntervalSinceDate:convention_.start_time] / 3600.0f;
		timeY_ = timeY_ * LCUITimeTableTimeHeight;		
	} else {
		timeY_ = -100.0f;
	}
	
	if (userEventIDs_ != nil)
		[userEventIDs_ release];
	userEventIDs_ = [[[convention_.usersProgramme getEventsInFilter] valueForKeyPath:@"objectID"] retain];
	[super setNeedsLayout];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if (notify_)
		[[NSNotificationCenter defaultCenter] postNotificationName:LCUITimeTableViewScroll object:nil];
}

-(void)enableNotifications {
	notify_ = YES;
}

-(void)disableNotifications {
	notify_ = NO;
}

/*- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	[[NSNotificationCenter defaultCenter] postNotificationName:LCUITimeTableViewScroll object:nil];
}*/

- (void)dealloc {
	if (start_ != nil)
		[start_ release];
	if (end_ != nil)
		[end_ release];
	if (venues_ != nil)
		[venues_ release];
	if (userEventIDs_ != nil)
		[userEventIDs_ release];
	
	[column1Color_ release];
	[column2Color_ release];
	[textColor_	release];
	[borderColor_ release];
	[timeLineColor_ release];
	
	[font_ release];
    [super dealloc];
}

@end
