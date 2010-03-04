#import "_DRModel.h"

@interface DRModel : _DRModel {}
+ (DRModel *)sharedDRModel;

// Custom Methods Go Here
- (void) getImageWithURL:(NSURL*)imageURL andUserInfo:(NSMutableDictionary*)userInfo andTarget:(UIViewController*)target andCallback:(SEL)selector;
- (void) getJSONWithURL:(NSURL*)jsonURL andUserInfo:(NSMutableDictionary*)userInfo andTarget:(UIViewController*)target andCallback:(SEL)selector;


- (void) getSampleObject;

@end
