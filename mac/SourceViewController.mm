#import "SourceViewController.h"

#import "SourceLineItem.h"

@interface SourceViewController ()

@property(nonatomic, assign) IBOutlet NSCollectionView *collectionView;

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

- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(NSCollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  NSMutableArray *lines = self.representedObject;
  return lines.count;
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView
     itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath {
  SourceLineItem *item = [collectionView makeItemWithIdentifier:@"SourceLineItem"
                                                   forIndexPath:indexPath];
  NSMutableArray *lines = self.representedObject;
  item.source.stringValue = [lines objectAtIndex:indexPath.item];
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
