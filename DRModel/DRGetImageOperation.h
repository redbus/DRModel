//
//  DRGetImageOperation.m
//  sciphone
//
//  Created by Daniel Ricciotti on 1/21/10.
//  Copyright 2010 Daniel Ricciotti. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Constants.h"

@interface DRGetImageOperation : NSOperation {
	NSURL *objectURL;
	NSNumber *index;
	NSNumber *objectIdentifier;
	UIViewController *mainViewController;
	SEL callback;
}
@property (nonatomic, retain) NSURL *objectURL;
@property (nonatomic, retain) NSNumber *objectIdentifier;
- (id)initWithViewController:(UIViewController *)viewController andIndex:(int)number;
- (void) setCallback:(SEL)select;
@end