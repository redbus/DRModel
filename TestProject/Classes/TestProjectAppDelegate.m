//
//  TestProjectAppDelegate.m
//  TestProject
//
//  Created by Daniel Ricciotti on 3/1/10.
//  Copyright Daniel Ricciotti 2010. All rights reserved.
//

#import "TestProjectAppDelegate.h"
#import "TestProjectViewController.h"

@implementation TestProjectAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
