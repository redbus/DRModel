//
//  DRGetImageOperation.h
//
//  Created by Daniel Ricciotti on 1/21/10.
//  Copyright 2010 Daniel Ricciotti. All rights reserved.
//
#import "DRGetImageOperation.h"
#import "JSON.h"

@interface DRGetImageOperation (hidden)
@end

@implementation DRGetImageOperation
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
	NSError *error = nil;
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:objectURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:kImageTimeout];
	data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSMutableDictionary *infoBundle = [[NSMutableDictionary alloc] initWithDictionary:userInfo];
	if (error == nil) {
		NSLog(@"Image Loaded");
		UIImage *photo = [UIImage imageWithData:data];
		if (photo) {
			[infoBundle setObject:photo forKey:@"image"];
			[target performSelectorOnMainThread:callback
												 withObject:infoBundle
											  waitUntilDone:YES];
			[pool release];
			return;	
		}
		NSLog(@"Image is not valid");
		// URL is not a valid image object
		//NSError *newError = [NSError errorWithDomain:[error domain] code:1 userInfo:nil];
		[infoBundle setObject:@"ERROR!" forKey:@"error"];
		[target performSelectorOnMainThread:callback
								 withObject:infoBundle
							  waitUntilDone:YES];
		return;
	}
	NSLog(@"Image Failed - %s", [error localizedDescription]);
	[infoBundle setObject:error forKey:@"error"];
	[target performSelectorOnMainThread:callback
										 withObject:infoBundle
									  waitUntilDone:YES];
	[infoBundle release];
	[pool release];
}

@end