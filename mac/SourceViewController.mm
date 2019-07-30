#import "SourceViewController.h"

#import "Document.h"

@interface SourceViewController ()

@property(nonatomic, weak) IBOutlet NSTextView *sourceTextView;
@property(nonatomic, weak) IBOutlet NSTextField *outputTextField;

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
  auto &doc = self.document.content;
  auto &source = doc.source();
  self.sourceTextView.string = [NSString stringWithCString:source.c_str()
                                                  encoding:NSUTF8StringEncoding];
  auto *font = [NSFont fontWithName:@"Courier" size:25];
  auto *attrs = @{NSFontAttributeName : font};
  [self.sourceTextView.textStorage setAttributes:attrs range:NSMakeRange(0, doc.source().size())];
  auto *highlight_attrs = @{@"Highlight" : @1, NSFontAttributeName : font};
  auto loc = source.find("print");
  [self.sourceTextView.textStorage setAttributes:highlight_attrs range:NSMakeRange(loc, 5)];
}

- (IBAction)execute:(id)sender {
  auto &doc = self.document.content;
  doc.execute();
  self.outputTextField.stringValue = [NSString stringWithCString:doc.output().c_str()
                                                        encoding:NSUTF8StringEncoding];
}

@end
