#import <Cocoa/Cocoa.h>

#import <document.hpp>

@interface Document : NSDocument

- (marlin::document&)content;

@end
