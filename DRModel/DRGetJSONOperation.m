#define LOGS FALSE
#import "Log.h"
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
@synthesize bundle;

- (id)initWithViewController:(UIViewController *)viewController andBundle:(NSObject*)userBundle {
    if (self = [super init]) {
		objectURL = nil;
		mainViewController = [viewController retain];
		bundle = [userBundle copy];
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
- (void)main {
	PrintCalled;
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	NSData *data = nil;
	NSHTTPURLResponse *response = NULL;
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:objectURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:kDataTimeout];
	NSLog(@"URL = %@", objectURL);
	
	NSError *error = nil;
	data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"Request finished. Error = %@",[error localizedDescription]);
    if (error == nil) {
	//if (FALSE) {
		NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
		NSLog(@"JSON data = %@", jsonData);
		NSDictionary *jsonDict = [jsonData JSONValue];
		NSLog(@"JSON DICT = %@", jsonDict);
		[jsonData release];
		[mainViewController performSelectorOnMainThread:callback
											 withObject:[NSArray arrayWithObjects:jsonDict, bundle, nil] 
										  waitUntilDone:YES];
		[pool release];
		return;
	}
	NSLog(@"Error Did Happen. Sending Nil Array");
	[mainViewController performSelectorOnMainThread:callback
										 withObject:[NSArray arrayWithObjects:nil] 
									  waitUntilDone:YES];
	[pool release];
}

@end