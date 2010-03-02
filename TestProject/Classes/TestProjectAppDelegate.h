//
//  TestProjectAppDelegate.h
//  TestProject
//
//  Created by Daniel Ricciotti on 3/1/10.
//  Copyright Daniel Ricciotti 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestProjectViewController;

@interface TestProjectAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TestProjectViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TestProjectViewController *viewController;

@end

