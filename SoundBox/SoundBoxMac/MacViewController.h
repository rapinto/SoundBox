//
//  MacViewController.h
//  SoundBoxMac
//
//  Created by julien gimenez on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//


#import <Cocoa/Cocoa.h>


#import "PlayerProtocol.h"


@interface MacViewController : NSViewController  <NSCollectionViewDelegate, NSCollectionViewDataSource, PlayerProtocol, NSStreamDelegate>


@property (nonatomic,strong) NSArray * contents;


@property (assign) IBOutlet NSCollectionView * collectionView;


@property (nonatomic, retain) NSInputStream * inputStream;


@property (nonatomic, retain) NSOutputStream * outputStream;


@end
