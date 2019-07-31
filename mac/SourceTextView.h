#import <Cocoa/Cocoa.h>

@protocol SourceTextViewDelegate;

@interface SourceTextView : NSTextView

@property (weak) id<SourceTextViewDelegate> sourceDelegate;

@end

@protocol SourceTextViewDelegate

- (void)textView:(SourceTextView*)textView clickAtIndex:(NSUInteger)index;

@end
