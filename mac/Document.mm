#import "Document.h"

#import "NSObject+Casting.h"
#import "SourceViewController.h"

@interface Document () {
  std::optional<marlin::document> _content;
}

@end

@implementation Document

- (instancetype)init {
  if (self = [super init]) {
  }
  return self;
}

+ (BOOL)autosavesInPlace {
  return YES;
}

- (std::optional<marlin::document> &)content {
  return _content;
}

- (void)makeWindowControllers {
  NSWindowController *controller = [[NSStoryboard storyboardWithName:@"Main" bundle:nil]
      instantiateControllerWithIdentifier:@"Document Window Controller"];
  [self addWindowController:controller];
  if (auto *vc = [SourceViewController cast:controller.contentViewController]) {
    vc.document = self;
    if (_content) {
      [vc setNeedsUpdate];
    }
  }
}

- (void)update {
  for (NSWindowController *controller in self.windowControllers) {
    if (auto *vc = [SourceViewController cast:controller.contentViewController]) {
      [vc setNeedsUpdate];
    }
  }
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
  // Insert code here to write your document to data of the specified type. If outError != NULL,
  // ensure that you create and set an appropriate error if you return nil. Alternatively, you could
  // remove this method and override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or
  // -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
  [NSException raise:@"UnimplementedMethod"
              format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
  return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
  NSString *source = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
  _content.emplace(source.UTF8String);
  [self update];
  return YES;
}

@end
