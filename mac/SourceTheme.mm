#import "SourceTheme.h"

#import "document.hpp"

@implementation SourceTheme

- (instancetype)init {
  if (self = [super init]) {
    auto *font = [NSFont fontWithName:@"Courier" size:25];
    _allAttrs = @{NSFontAttributeName : font};
    _opAttrs = @{NSFontAttributeName : font, NSForegroundColorAttributeName : NSColor.brownColor};
    _booleanAttrs =
        @{NSFontAttributeName : font, NSForegroundColorAttributeName : NSColor.blueColor};
    _numberAttrs =
        @{NSFontAttributeName : font, NSForegroundColorAttributeName : NSColor.greenColor};
    _stringAttrs =
        @{NSFontAttributeName : font, NSForegroundColorAttributeName : NSColor.cyanColor};
    _focusAttrs = @{NSFontAttributeName : font, @"Focus" : @YES};
  }
  return self;
}

@end
