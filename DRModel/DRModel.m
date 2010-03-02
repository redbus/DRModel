#import "DRModel.h"
#import "SynthesizeSingleton.h"
#import "DRGetJSONOperation.h"

#define VIDEO_SOURCE_URL @"http://superspectacularadventures.com/mobile/mobilevideosv2.php"

@implementation DRModel
SYNTHESIZE_SINGLETON_FOR_CLASS(DRModel)

- (void) getVideoList:(cacheOption)shouldCache andTarget:(UIViewController*)target andCallback:(SEL)selector {
	DRGetJSONOperation *operation = [[DRGetJSONOperation alloc] initWithViewController:target andBundle:nil];
	NSURL *objectURL = [NSURL URLWithString:VIDEO_SOURCE_URL];
	[operation setObjectURL:objectURL];
	[operation setCallback:selector];
	[self addOperation:operation toPool:specialPoolDontCare];
	[operation release];
}
@end