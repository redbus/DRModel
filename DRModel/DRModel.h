#import "_DRModel.h"
#import "Constants.h"

@interface DRModel : _DRModel {}
+ (DRModel *)sharedDRModel;

// Custom Methods Go Here
- (void) getVideoList:(cacheOption)shouldCache andTarget:(UIViewController*)target andCallback:(SEL)selector;

@end
