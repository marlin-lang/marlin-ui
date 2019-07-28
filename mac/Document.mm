#import "Document.h"

@interface Document () {
    marlin::document _document;
}

@end

@implementation Document

- (instancetype)init {
  self = [super init];
  if (self) {
    // Add your subclass-specific initialization here.
  }
  return self;
}

+ (BOOL)autosavesInPlace {
  return YES;
}

- (marlin::document *)document {
    return &_document;
}

- (void)makeWindowControllers {
  // Override to return the Storyboard file name of the document.
  NSWindowController *controller = [[NSStoryboard storyboardWithName:@"Main" bundle:nil]
      instantiateControllerWithIdentifier:@"Document Window Controller"];
  controller.contentViewController.representedObject = self;
  [self addWindowController:controller];
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
  _document.set_source(source.UTF8String);
  return YES;
}

@end
