#import "Document.h"

@interface Document ()

@end

@implementation Document

@synthesize lines;

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

- (void)makeWindowControllers {
  // Override to return the Storyboard file name of the document.
  NSWindowController *controller = [[NSStoryboard storyboardWithName:@"Main" bundle:nil]
      instantiateControllerWithIdentifier:@"Document Window Controller"];
  controller.contentViewController.representedObject = lines;
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
  lines = [[source componentsSeparatedByString:@"\n"] mutableCopy];
  return YES;
}

@end
