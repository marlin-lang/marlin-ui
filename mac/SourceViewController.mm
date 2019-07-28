#import "SourceViewController.h"

#import "Document.h"
#import "SourceLineItem.h"

@interface SourceViewController ()

@property(nonatomic, assign) IBOutlet NSCollectionView *collectionView;
@property(nonatomic, assign) IBOutlet NSTextField *outputTextField;

@end

@implementation SourceViewController

@synthesize collectionView;

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewDidLayout {
  [super viewDidLayout];
  [collectionView reloadData];
}

- (IBAction)execute:(id)sender {
  Document *doc = self.representedObject;
  auto document = [doc document];
  document->execute();
  self.outputTextField.stringValue = [NSString stringWithCString:document->output().c_str()
                                                        encoding:NSUTF8StringEncoding];
}

- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(NSCollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  Document *doc = self.representedObject;
  auto document = [doc document];
  return document->line_count();
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView
     itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath {
  SourceLineItem *item = [collectionView makeItemWithIdentifier:@"SourceLineItem"
                                                   forIndexPath:indexPath];
  Document *doc = self.representedObject;
  auto document = [doc document];
  item.source.stringValue = [NSString stringWithCString:document->line_at(indexPath.item).c_str()
                                               encoding:NSUTF8StringEncoding];
  return item;
}

- (NSSize)collectionView:(NSCollectionView *)collectionView
                    layout:(NSCollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return {collectionView.bounds.size.width - 20, 35};
}

- (NSEdgeInsets)collectionView:(NSCollectionView *)collectionView
                        layout:(NSCollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
  return {10, 10, 10, 10};
}

- (CGFloat)collectionView:(NSCollectionView *)collectionView
                                 layout:(NSCollectionViewLayout *)collectionViewLayout
    minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 10;
}

- (CGFloat)collectionView:(NSCollectionView *)collectionView
                                      layout:(NSCollectionViewLayout *)collectionViewLayout
    minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  return 10;
}

@end
