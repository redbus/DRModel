//
//  DRGetCategoryOperation.h
//  sciphone
//
//  Created by Daniel Ricciotti on 1/22/10.
//  Copyright 2010 Daniel Ricciotti. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DRModelConstants.h"

@interface DRGetJSONOperation : NSOperation {
	NSURL *objectURL;
	UIViewController *target;
	SEL callback;
	NSMutableDictionary *userInfo;
}
@property (nonatomic, retain) NSMutableDictionary *userInfo;
@property (nonatomic, retain) NSURL *objectURL;

- (id)init;
- (void) setCallback:(SEL)select andTarget:(UIViewController*)callbackTarget;
@end