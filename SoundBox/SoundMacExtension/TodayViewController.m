//
//  TodayViewController.m
//  SoundMacExtension
//
//  Created by julien gimenez on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//


#import "TodayViewController.h"


#import <NotificationCenter/NotificationCenter.h>


#import "SoundItem.h"
#import "SoundCollectionViewItem.h"


@interface TodayViewController () <NCWidgetProviding>


@end


@implementation TodayViewController


- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult result))completionHandler {
    // Update your data and prepare for a snapshot. Call completion handler when you are done
    // with NoData if nothing has changed or NewData if there is new data since the last
    // time we called you
    completionHandler(NCUpdateResultNoData);
}


#pragma mark - Cocoa


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contents = [SoundItem appSoundItems];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[SoundCollectionViewItem class] forItemWithIdentifier:SoundCollectionViewItem_Identifier];
    [self.collectionView setContent:self.contents];
}


#pragma mark - NSCollectionViewDataSource


- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.contents count];
}


- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView makeItemWithIdentifier:SoundCollectionViewItem_Identifier forIndexPath:indexPath];
}


@end

