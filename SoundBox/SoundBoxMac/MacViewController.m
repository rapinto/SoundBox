//
//  MacViewController.m
//  SoundBoxMac
//
//  Created by julien gimenez on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//


#import "MacViewController.h"


#import "SoundItem.h"
#import "SoundCollectionViewItem.h"


@implementation MacViewController


#pragma mark - Cocoa


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contents = [SoundItem appSoundItems];
    [self.collectionView registerClass:[SoundCollectionViewItem class] forItemWithIdentifier:SoundCollectionViewItem_Identifier];
    [self.collectionView setContent:self.contents];
    
    [self initNetworkCommunication];
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
    SoundCollectionViewItem * cell = [collectionView makeItemWithIdentifier:SoundCollectionViewItem_Identifier forIndexPath:indexPath];
    cell.playerDelegate = self;
    
    return cell;
}


#pragma mark - Alex


- (void)initNetworkCommunication
{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"10.18.101.71", 7777, &readStream, &writeStream);
    
    _inputStream = (NSInputStream *)CFBridgingRelease(readStream);
    _outputStream = (NSOutputStream *)CFBridgingRelease(writeStream);
    
    [_inputStream setDelegate:self];
    [_outputStream setDelegate:self];
    
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [_inputStream open];
    [_outputStream open];
}


- (void)sendSoundWithFile:(NSString *)file;
{
    NSData * data = [[NSData alloc] initWithData:[file dataUsingEncoding:NSASCIIStringEncoding]];
    
    [_outputStream write:[data bytes] maxLength:[data length]];
}


- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    NSLog(@"coucou");
}


@end
