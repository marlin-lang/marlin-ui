#import "SourceViewController.h"

#import "Document.h"

@interface SourceViewController ()

@property(nonatomic, assign) IBOutlet NSTextView *sourceTextView;
@property(nonatomic, assign) IBOutlet NSTextField *outputTextField;

@end

@implementation SourceViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)setNeedsUpdate {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(update) object:nil];
    [self performSelector:@selector(update) withObject:nil afterDelay:0];
}

- (void)update {
    marlin::document &doc = self.document.content;
    self.sourceTextView.string = [NSString stringWithCString:doc.source().c_str()
                                                    encoding:NSUTF8StringEncoding];
}

- (IBAction)execute:(id)sender {
  marlin::document &doc = self.document.content;
  doc.execute();
  self.outputTextField.stringValue = [NSString stringWithCString:doc.output().c_str()
                                                        encoding:NSUTF8StringEncoding];
}

@end
