#import <Cocoa/Cocoa.h>

#import "Document.h"

@interface SourceViewController : NSViewController

@property (nonatomic, assign) Document* document;

- (void)setNeedsUpdate;

@end
