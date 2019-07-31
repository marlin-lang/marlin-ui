#import <Cocoa/Cocoa.h>

#import <optional>

#import <document.hpp>

@interface Document : NSDocument

- (std::optional<marlin::document>&)content;

@end
