//
//  TestProjectViewController.m
//  TestProject
//
//  Created by Daniel Ricciotti on 3/1/10.
//  Copyright Daniel Ricciotti 2010. All rights reserved.
//

#import "TestProjectViewController.h"
#import "DRModel.h"
#import "DRModelConstants.h"

@implementation TestProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction) buttonWasPressed {
	submitButton.enabled = FALSE;
	[textView resignFirstResponder];
	[submitButton setTitle:@"Loading.." forState:UIControlStateNormal];
	[submitButton setAlpha:0.3];
	[jsonButton setEnabled:FALSE];
	[jsonButton setAlpha:0.3];
	imageView.image = nil;
	

	NSString *imageURL_string = [textView text];
	NSURL *imageURL;
	if ((imageURL_string != nil) && ([imageURL_string length] > 0)) {
		imageURL = [NSURL URLWithString:imageURL_string];
	} else {
		NSLog(@"Using default Image");
		imageURL = [NSURL URLWithString:@"http://ecx.images-amazon.com/images/I/41D98HW4T8L._SL500_AA240_.jpg"];	
		// default image to use if URL is nil
	}
	NSMutableDictionary *userBundle = [[NSDictionary alloc] init];
	[[DRModel sharedDRModel] getImageWithURL:imageURL 
								 andUserInfo:[userBundle copy]
								   andTarget:self 
								 andCallback:@selector(imageDidFinish:)];
	[userBundle release];
}

- (void) jsonButtonWasPressed {
	submitButton.enabled = FALSE;
	[textView resignFirstResponder];
	[submitButton setTitle:@"Loading.." forState:UIControlStateNormal];
	[submitButton setAlpha:0.3];
	[jsonButton setEnabled:FALSE];
	[jsonButton setAlpha:0.3];
	imageView.image = nil;
	
	NSMutableDictionary *userBundle = [[NSDictionary alloc] init];
	NSURL *url = [NSURL URLWithString:@"http://theredb.us/olympics/mobile.php?action=getcategory&catid=6&start=0&end=10"];
	[[DRModel sharedDRModel] getJSONWithURL:url 
								 andUserInfo:[userBundle copy]
								   andTarget:self 
								 andCallback:@selector(jsonDidFinish:)];
	[userBundle release];
}

- (void) jsonDidFinish:(NSDictionary*)response {
	NSLog(@"JSON Finished Loading");
	if ((response != nil) && ([response objectForKey:@"error"] == nil)) {
		NSDictionary *jsonDict = [response objectForKey:@"jsonDict"];
		if (jsonDict != nil) {
			NSLog(@"JSON Response = %@", jsonDict);
		}
	}
	[submitButton setAlpha:1.0];
	submitButton.enabled = TRUE;
	[jsonButton setAlpha:1.0];
	[jsonButton setEnabled:TRUE];
}

- (void) imageDidFinish:(NSDictionary*)response {
	NSLog(@"Image Finished Loading");
	if ((response != nil) && ([response objectForKey:@"error"] == nil)) {
		UIImage *image = [response objectForKey:@"image"];
		if (image != nil) {
			imageView.image = image;
			[submitButton setTitle:@"Image Loaded! Load Again?" forState:UIControlStateNormal];
			[submitButton setAlpha:1.0];
			submitButton.enabled = TRUE;
			[jsonButton setAlpha:1.0];
			[jsonButton setEnabled:TRUE];
			return;
		}
	}
	imageView.image = [UIImage imageNamed:@"error-loading.png"];
	[submitButton setTitle:@"Image Failed! Load Again?" forState:UIControlStateNormal];
	[submitButton setAlpha:1.0];
	submitButton.enabled = TRUE;
	[jsonButton setAlpha:1.0];
	[jsonButton setEnabled:TRUE];
}

@end
