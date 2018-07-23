//
//  ViewController.m
//  SoundBoxMac
//
//  Created by julien gimenez on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//

#import "ViewController.h"


#import "SoundItem.h"
#import "SoundCollectionViewItem.h"


@interface ViewController () <NSCollectionViewDelegate, NSCollectionViewDataSource>


@property (nonatomic,strong) NSArray * contents;


@property (assign) IBOutlet NSCollectionView * collectionView;


@end


@implementation ViewController


#pragma mark - Cocoa


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contents = [SoundItem appSoundItems];
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
