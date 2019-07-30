#import "SourceViewController.h"

#import "Document.h"
#import "SourceTheme.h"

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
  auto *theme = [SourceTheme new];
  [self.sourceTextView.textStorage setAttributes:theme.allAttrs
                                           range:NSMakeRange(0, source.size())];

  doc.for_each_highlight([self, theme](marlin::format::highlight::token_type type, int start,
                                       int len) {
    switch (type) {
      case marlin::format::highlight::token_type::op:
        [self.sourceTextView.textStorage setAttributes:theme.opAttrs range:NSMakeRange(start, len)];
        break;
      case marlin::format::highlight::token_type::boolean:
        [self.sourceTextView.textStorage setAttributes:theme.booleanAttrs
                                                 range:NSMakeRange(start, len)];
        break;
      case marlin::format::highlight::token_type::number:
        [self.sourceTextView.textStorage setAttributes:theme.numberAttrs
                                                 range:NSMakeRange(start, len)];
        break;
      case marlin::format::highlight::token_type::string:
        [self.sourceTextView.textStorage setAttributes:theme.stringAttrs
                                                 range:NSMakeRange(start, len)];
        break;
      default:
        break;
    }
  });

  auto loc = source.find("print");
  [self.sourceTextView.textStorage setAttributes:theme.focusAttrs range:NSMakeRange(loc, 5)];
}

- (IBAction)execute:(id)sender {
  auto &doc = self.document.content;
  doc.execute();
  self.outputTextField.stringValue = [NSString stringWithCString:doc.output().c_str()
                                                        encoding:NSUTF8StringEncoding];
}

@end
