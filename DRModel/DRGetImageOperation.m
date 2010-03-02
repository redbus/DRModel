#define LOGS FALSE
#import "Log.h"
//
//  DRGetImageOperation.h
//  sciphone
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
@synthesize objectIdentifier;

- (id)initWithViewController:(UIViewController *)viewController andIndex:(int)number {
    if (self = [super init]) {
		objectURL = nil;
		callback = nil;
		index = [NSNumber numberWithInt:number];
		mainViewController = [viewController retain];
    }
    return self;
}
- (void) setCallback:(SEL)select {
	callback = select;
}
- (void)dealloc {
	[objectURL release];
	[mainViewController release];
    [super dealloc];
}
// Cache code
// NSLog(@"Cache size after = %d bytes", [[NSURLCache sharedURLCache] currentMemoryUsage]);
- (void)main {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	NSLog(@"DRGetImage, URL = %@", objectURL);
	/*
	 NSLog(@"Cache memory capacity = %d bytes", [[NSURLCache sharedURLCache] memoryCapacity]);
	NSLog(@"Cache disk capacity = %d bytes", [[NSURLCache sharedURLCache] diskCapacity]);
	NSLog(@"Cache Memory Usage = %d bytes", [[NSURLCache sharedURLCache] currentMemoryUsage]);
	NSLog(@"Cache Disc Usage = %d bytes", [[NSURLCache sharedURLCache] currentDiskUsage]);
	 */
	NSData *data = nil;
	NSHTTPURLResponse *response = NULL;
	NSError *error = nil;
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:objectURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:kImageTimeout];
	data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	//NSCachedURLResponse *cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:[NSData dataWithBytes:" " length:1]];
	//[[NSURLCache sharedURLCache] storeCachedResponse:cachedResponse forRequest:request];

	
	NSLog(@"Image Request finished. ID = %d, Error = %@",[objectIdentifier intValue],[error localizedDescription]);
	//NSLog(@"Cache size after = %d bytes", [[NSURLCache sharedURLCache] currentMemoryUsage]);
    if (error == nil) {
		//NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
		//[[NSURLCache sharedURLCache] storeCachedResponse:cachedResponse forRequest:request];
		
		UIImage *photo = [UIImage imageWithData:data];
		if (photo) {
			[mainViewController performSelectorOnMainThread:callback
												 withObject:[NSArray arrayWithObjects:photo, objectIdentifier, nil] 
											  waitUntilDone:YES];
			[pool release];
			return;	
		}
		
	}
	// ELSE (Error happened)
	[mainViewController performSelectorOnMainThread:callback
										 withObject:[NSArray arrayWithObjects:objectIdentifier,nil] 
									  waitUntilDone:YES];
	[pool release];
}

@end