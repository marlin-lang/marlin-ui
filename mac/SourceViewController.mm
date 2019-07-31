#import "SourceViewController.h"

#import "Document.h"
#import "SourceTheme.h"

@interface SourceViewController ()

@property(nonatomic, weak) IBOutlet SourceTextView *sourceTextView;
@property(nonatomic, weak) IBOutlet NSTextField *outputTextField;

@end

@implementation SourceViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.sourceTextView.sourceDelegate = self;
}

- (void)setNeedsUpdate {
  [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(update) object:nil];
  [self performSelector:@selector(update) withObject:nil afterDelay:0];
}

- (void)update {
  auto &doc = self.document.content;
  auto &source_str = doc->source_str();
  self.sourceTextView.string = [NSString stringWithCString:source_str.c_str()
                                                  encoding:NSUTF8StringEncoding];
  auto *theme = [SourceTheme new];
  [self.sourceTextView.textStorage setAttributes:theme.allAttrs
                                           range:NSMakeRange(0, source_str.size())];

  doc->for_each_highlight([self, theme](marlin::format::highlight::token_type type, int start,
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
}

- (IBAction)execute:(id)sender {
  auto &doc = self.document.content;
  doc->execute();
  self.outputTextField.stringValue = [NSString stringWithCString:doc->output().c_str()
                                                        encoding:NSUTF8StringEncoding];
}

- (void)textView:(SourceTextView *)textView clickAtIndex:(NSUInteger)index {
  auto &doc = self.document.content;
  auto [begin, len]{doc->code_range_contains_index(index)};
  auto *theme = [SourceTheme new];
  [self.sourceTextView.textStorage removeAttribute:theme.NSSelectionAttributeName
                                             range:NSMakeRange(0, doc->source_str().size())];
  [self.sourceTextView.textStorage addAttribute:theme.NSSelectionAttributeName
                                          value:@YES
                                          range:NSMakeRange(begin, len)];
}

@end
