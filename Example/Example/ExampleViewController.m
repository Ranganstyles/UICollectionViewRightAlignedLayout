
#import "ExampleViewController.h"
#import <UICollectionViewRightAlignedLayout.h>
#import <UIColor+FlatColors.h>
#import <UIFont+OpenSans.h>

static NSString * const kCellIdentifier = @"CellIdentifier";
static BOOL kShouldRefresh = NO;

@interface ExampleViewController () <UICollectionViewDataSource, UICollectionViewDelegateRightAlignedLayout>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ExampleViewController

- (instancetype)init
{
    return [super initWithNibName:@"ExampleViewController" bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.titleLabel.font = [UIFont openSansFontOfSize:self.titleLabel.font.pointSize];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.textColor = [UIColor flatNephritisColor];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];

    [self.view addSubview:self.collectionView];

    if (kShouldRefresh) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self.collectionView selector:@selector(reloadData) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self.timer invalidate];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];

    cell.contentView.layer.borderColor = [UIColor flatEmeraldColor].CGColor;
    cell.contentView.layer.borderWidth = 2;

    return cell;
}

#pragma mark - UICollectionViewDelegateRightAlignedLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat randomWidth = (arc4random() % 120) + 60;
    return CGSizeMake(randomWidth, 60);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

#pragma mark -

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
