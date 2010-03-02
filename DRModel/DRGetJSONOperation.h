//
//  DRGetCategoryOperation.h
//  sciphone
//
//  Created by Daniel Ricciotti on 1/22/10.
//  Copyright 2010 Daniel Ricciotti. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Constants.h"

@interface DRGetJSONOperation : NSOperation {
	NSURL *objectURL;
	NSObject *bundle;
	UIViewController *mainViewController;
	SEL callback;
}
@property (nonatomic, retain) NSURL *objectURL;
@property (nonatomic, copy) NSObject *bundle;
- (id)initWithViewController:(UIViewController *)viewController andBundle:(NSObject*)userBundle;
- (void) setCallback:(SEL)select;
@end