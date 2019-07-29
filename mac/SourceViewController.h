#import <Cocoa/Cocoa.h>

#import "Document.h"

@interface SourceViewController : NSViewController

@property(nonatomic, weak) Document* document;

- (void)setNeedsUpdate;

@end
