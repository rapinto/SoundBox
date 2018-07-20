//
//  TodayViewController.h
//  SoundMacExtension
//
//  Created by julien gimenez on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TodayViewController : NSViewController <NSCollectionViewDelegate, NSCollectionViewDataSource>


@property (nonatomic,strong) NSArray * contents;


@property (assign) IBOutlet NSCollectionView * collectionView;


@end
