//
//  TestProjectViewController.h
//  TestProject
//
//  Created by Daniel Ricciotti on 3/1/10.
//  Copyright Daniel Ricciotti 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestProjectViewController : UIViewController {
	IBOutlet UIButton *submitButton;
	IBOutlet UIImageView *imageView;
	IBOutlet UITextField *textView;
	IBOutlet UIButton *jsonButton;
}
- (IBAction) buttonWasPressed;
- (IBAction) jsonButtonWasPressed;

- (void) jsonDidFinish:(NSDictionary*)response;
- (void) imageDidFinish:(NSDictionary*)response;

@end

