// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to imageObject.m instead.

#import "_imageObject.h"

@implementation imageObjectID
@end

@implementation _imageObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"imageObject" inManagedObjectContext:moc_];
}

- (imageObjectID*)objectID {
	return (imageObjectID*)[super objectID];
}




@dynamic jsonValue;






@dynamic url;






@dynamic timestamp;








@end
