#import "SourceTextView.h"

#import "SourceTheme.h"

@interface SourceTextView () {
  NSRange _selectionRange;
}

@end

@implementation SourceTextView

- (instancetype)initWithCoder:(NSCoder*)coder {
  if (self = [super initWithCoder:coder]) {
    _selectionRange = NSMakeRange(0, 0);
  }
  return self;
}

- (void)mouseDown:(NSEvent*)theEvent {
  [super mouseDown:theEvent];

  auto eventLocation = [theEvent locationInWindow];
  auto loc = [self convertPoint:eventLocation fromView:nil];
  auto index = [self characterIndexForInsertionAtPoint:loc];
  _selectionRange = [self.dataSource textView:self selectRageContainsIndex:index];
  [self setNeedsDisplayInRect:self.bounds avoidAdditionalLayout:YES];
}

- (void)mouseMoved:(NSEvent*)event {
  [[NSCursor arrowCursor] set];
}

- (void)drawViewBackgroundInRect:(NSRect)rect {
  [super drawViewBackgroundInRect:rect];
  if (_selectionRange.length > 0) {
    auto* theme = [SourceTheme new];
    NSSize oneCharSize = [@"a" sizeWithAttributes:theme.allAttrs];

    NSRange range = [self.layoutManager glyphRangeForCharacterRange:_selectionRange
                                               actualCharacterRange:NULL];
    NSRect rect = [self.layoutManager boundingRectForGlyphRange:range
                                                inTextContainer:self.textContainer];
    rect.origin.x += self.textContainerOrigin.x;
    rect.origin.y += self.textContainerOrigin.y;
    rect = [self convertRectToLayer:rect];
    NSRect borderRect = NSMakeRect(rect.origin.x - oneCharSize.width * 0.25, rect.origin.y + 1,
                                   rect.size.width + oneCharSize.width * 0.5, rect.size.height);
    [NSGraphicsContext saveGraphicsState];
    NSBezierPath* path = [NSBezierPath bezierPathWithRoundedRect:borderRect
                                                         xRadius:5.0f
                                                         yRadius:5.0f];
    NSColor* fillColor = [NSColor colorWithCalibratedRed:237.0 / 255.0
                                                   green:243.0 / 255.0
                                                    blue:252.0 / 255.0
                                                   alpha:1];
    NSColor* strokeColor = [NSColor colorWithCalibratedRed:163.0 / 255.0
                                                     green:188.0 / 255.0
                                                      blue:234.0 / 255.0
                                                     alpha:1];
    [path addClip];
    [fillColor setFill];
    [strokeColor setStroke];
    NSRectFillUsingOperation(borderRect, NSCompositingOperationSourceOver);
    NSAffineTransform* transform = [NSAffineTransform transform];
    [transform translateXBy:0.5 yBy:0.5];
    [path transformUsingAffineTransform:transform];
    [path stroke];
    [transform translateXBy:-1.5 yBy:-1.5];
    [path transformUsingAffineTransform:transform];
    [path stroke];
    [NSGraphicsContext restoreGraphicsState];
  }
}

@end
