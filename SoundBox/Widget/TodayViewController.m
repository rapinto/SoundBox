//
//  TodayViewController.m
//  Widget
//
//  Created by rpinto on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "SoundCollectionViewCell.h"
#import "SoundItem.h"


static const CGSize maxCompactSize = {320, 86};
static const CGSize maxExpandedSize = {320, 359};


@interface TodayViewController () <NCWidgetProviding>


@property (nonatomic,strong) AVAudioPlayer * player;


@property (nonatomic,strong) NSMutableArray * soundItems;


@property (nonatomic,strong) SoundItem * currentItem;


@end


@implementation TodayViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.extensionContext setWidgetLargestAvailableDisplayMode:NCWidgetDisplayModeExpanded];
    
    self.soundItems = [SoundItem appSoundItems];
    
    [self configureCollectionView];
    
//    [self enableReorder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}


- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    NSLog(@"maxSize %@", [NSValue valueWithCGSize:maxSize]);
    
    NSLog(@"activeDisplayMode %lu with maxSize %@", activeDisplayMode, [NSValue valueWithCGSize:maxSize]);
    if (activeDisplayMode == NCWidgetDisplayModeCompact)
    {
        [self updateToWidgetCompactMode];
        self.preferredContentSize = maxCompactSize;
    }
    else if (activeDisplayMode == NCWidgetDisplayModeExpanded)
    {
        [self updateToWidgetExpandedMode];
        self.preferredContentSize = maxExpandedSize;
    }
    
    [self.collectionView reloadData];
}


- (CGSize)widgetMaximumSizeForDisplayMode:(NCWidgetDisplayMode)displayMode
{
    NSLog(@"activeDisplayMode %lu", displayMode);
    if (displayMode == NCWidgetDisplayModeCompact)
    {
        return maxCompactSize;
    }
    else if (displayMode == NCWidgetDisplayModeExpanded)
    {
        return maxExpandedSize;
    }
    
    return CGSizeZero;
}


#pragma mark - Private


- (void)updateToWidgetCompactMode
{
//    self.view.backgroundColor = [UIColor redColor];
}


- (void)updateToWidgetExpandedMode
{
//    self.view.backgroundColor = [UIColor blueColor];
}


- (void)playSoundAtIndexPath:(NSIndexPath *)indexPath
{
    SoundItem * item = [self.soundItems objectAtIndex:indexPath.row];
    self.currentItem = item;
    
    [self.collectionView reloadData];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:item.filePath];
    
    NSError *error;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                         error:&error];
    self.player.numberOfLoops = 0; //Infinite
    self.player.delegate  = self;
    [self.player play];
}


- (void)stopCurrentPlayingSound
{
    [self.player stop];
    
    [self deletePlayer];
}


- (void)deletePlayer
{
    self.player = nil;
    self.currentItem = nil;
    
    [self.collectionView reloadData];
}


#pragma mark - Collection View Edit


- (void)enableReorder
{
    UILongPressGestureRecognizer * gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.view addGestureRecognizer:gestureRecognizer];
}


- (void)handleLongPress:(UILongPressGestureRecognizer*)gesture
{
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath *indexPath=[self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
            if(indexPath!=nil)
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self.collectionView endInteractiveMovement];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            [self.collectionView cancelInteractiveMovement];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:self.collectionView]];
        }
            break;
        default:
            break;
    }
//    self.collectionView.edit
}


#pragma mark - CollectionView


- (void)configureCollectionView
{
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    
    UINib * nib = [UINib nibWithNibName:SoundCollectionViewCell_Identifier bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:SoundCollectionViewCell_Identifier];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.extensionContext.widgetActiveDisplayMode == NCWidgetDisplayModeCompact)
    {
        return 4;
    }
    else
    {
        return 16;
    }
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SoundCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:SoundCollectionViewCell_Identifier forIndexPath:indexPath];
    
    if ([self.soundItems count] > indexPath.row)
    {
        SoundItem * item = [self.soundItems objectAtIndex:indexPath.row];
        
        BOOL isPlaying = item == self.currentItem;
        
        [cell updateWithSoundItem:item isPlaying:isPlaying];
    }
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width, height;
    if (self.extensionContext.widgetActiveDisplayMode == NCWidgetDisplayModeCompact)
    {
        height = (collectionView.frame.size.width - 39) / 4;
        width = (collectionView.frame.size.width - 39) / 4;
    }
    else
    {
        height = (maxExpandedSize.height - 39) / 4;
        width = (collectionView.frame.size.width - 39) / 4;
    }
    
//    NSLog(@"sizeForItemAtIndexPath %@", [NSValue valueWithCGSize:CGSizeMake(width, height)]);
    return CGSizeMake(width, height);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(12, 12, 12, 12);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.extensionContext.widgetActiveDisplayMode == NCWidgetDisplayModeCompact)
    {
        return 0;
    }
    else
    {
        return 5;
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.player != nil)
    {
        [self stopCurrentPlayingSound];
    }
    else
    {
        [self playSoundAtIndexPath:indexPath];
    }
    
}


- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    [self.soundItems exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    
    [self.collectionView reloadData];
}


#pragma mark - AVAudio Player


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self deletePlayer];
}


@end
