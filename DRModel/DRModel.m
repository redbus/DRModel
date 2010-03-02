#import "DRModel.h"
#import "SynthesizeSingleton.h"

// Include custom NSOperation classes
#import "DRGetImageOperation.h"
#import "DRGetJSONOperation.h"

@implementation DRModel
SYNTHESIZE_SINGLETON_FOR_CLASS(DRModel)

- (void) getImageWithURL:(NSURL*)imageURL andUserInfo:(NSMutableDictionary*)userInfo andTarget:(UIViewController*)target andCallback:(SEL)selector {
	
	DRGetImageOperation *operation = [[DRGetImageOperation alloc] init];
	[operation setCallback:selector andTarget:target];
	[operation setObjectURL:imageURL];
	[operation setUserInfo:userInfo];
	
	[self addOperation:operation toPool:specialPoolDontCare];
	[operation release];
	
}


- (void) getJSONWithURL:(NSURL*)jsonURL andUserInfo:(NSMutableDictionary*)userInfo andTarget:(UIViewController*)target andCallback:(SEL)selector {
	DRGetJSONOperation *operation = [[DRGetJSONOperation alloc] init];
	[operation setCallback:selector andTarget:target];
	[operation setObjectURL:jsonURL];
	[operation setUserInfo:userInfo];
	
	[self addOperation:operation toPool:specialPoolDontCare];
	[operation release];
}
@end