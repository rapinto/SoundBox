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
static const CGSize maxExpandedSize = {320, 384};


@interface TodayViewController () <NCWidgetProviding>


@property (nonatomic,strong) AVAudioPlayer * player;


@property (nonatomic,strong) NSMutableArray * soundItems;


@end


@implementation TodayViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.extensionContext setWidgetLargestAvailableDisplayMode:NCWidgetDisplayModeExpanded];
    
    [self generateSoundItems];
    
    [self configureCollectionView];
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


- (void)generateSoundItems
{
    self.soundItems = [NSMutableArray array];
    
    SoundItem * item = nil;
    NSString * filePath = nil;
    
    filePath = [[NSBundle mainBundle] pathForResource:@"dejapostee" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Déjà posté" filePath:filePath];
    [self.soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"autopromo" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Autopromo" filePath:filePath];
    [self.soundItems addObject:item];
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
    
    
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width, height;
    if (self.extensionContext.widgetActiveDisplayMode == NCWidgetDisplayModeCompact)
    {
        height = maxCompactSize.height;
        width = (collectionView.frame.size.width - 15) / 4;
    }
    else
    {
        height = (maxExpandedSize.height - 39) / 4;
        width = (collectionView.frame.size.width - 15) / 4;
    }
    
    return CGSizeMake(width, height);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(12, 0, 12, 0);
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
    SoundItem * item = [self.soundItems objectAtIndex:indexPath.row];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:item.filePath];
    
    NSError *error;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                         error:&error];
    self.player.numberOfLoops = 0; //Infinite
    self.player.delegate  = self;
    [self.player play];
}


#pragma mark - AVAudio Player


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.collectionView reloadData];
    self.player = nil;
}


@end
