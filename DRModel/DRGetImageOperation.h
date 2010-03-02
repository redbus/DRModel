//
//  DRGetImageOperation.m
//  sciphone
//
//  Created by Daniel Ricciotti on 1/21/10.
//  Copyright 2010 Daniel Ricciotti. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DRModelConstants.h"

@interface DRGetImageOperation : NSOperation {
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