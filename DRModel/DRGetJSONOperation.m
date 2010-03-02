//
//  DRGetCategoryOperation.m
//  sciphone
//
//  Created by Daniel Ricciotti on 1/22/10.
//  Copyright 2010 Daniel Ricciotti. All rights reserved.
//
#import "DRGetJSONOperation.h"
#import "json.h"

@implementation DRGetJSONOperation
@synthesize objectURL;
@synthesize userInfo;

- (id)init {
    if (self = [super init]) {
		objectURL = nil;
		callback = nil;
		target = nil;
		userInfo = nil;
    }
    return self;
}
- (void) setCallback:(SEL)select andTarget:(UIViewController*)callbackTarget {
	callback = select;
	target = callbackTarget;
}
- (void)dealloc {
    [super dealloc];
}

- (void)main {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	NSData *data = nil;
	NSHTTPURLResponse *response = NULL;
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:objectURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:kDataTimeout];
	NSError *error = nil;
	data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSMutableDictionary *infoBundle = [[NSMutableDictionary alloc] initWithDictionary:userInfo];
	if (error == nil) {
		NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
		NSDictionary *jsonDict = [jsonData JSONValue];
		[jsonData release];
		[infoBundle setObject:jsonDict forKey:@"jsonDict"];
		[target performSelectorOnMainThread:callback
											 withObject:infoBundle 
										  waitUntilDone:YES];
		[pool release];
		return;
	}
	[infoBundle setObject:error forKey:@"error"];
	[target performSelectorOnMainThread:callback
										 withObject:infoBundle
									  waitUntilDone:YES];
	[infoBundle release];
	[pool release];
}

@end