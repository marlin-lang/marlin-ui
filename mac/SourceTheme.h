#import <Cocoa/Cocoa.h>

@interface SourceTheme : NSObject

@property(readonly) NSDictionary* allAttrs;
@property(readonly) NSDictionary* opAttrs;
@property(readonly) NSDictionary* booleanAttrs;
@property(readonly) NSDictionary* numberAttrs;
@property(readonly) NSDictionary* stringAttrs;
@property(readonly) NSDictionary* focusAttrs;

@end
