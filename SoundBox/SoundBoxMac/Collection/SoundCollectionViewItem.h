//
//  SoundCollectionViewItem.h
//  SoundBoxMac
//
//  Created by julien gimenez on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const SoundCollectionViewItem_Identifier;

@interface SoundCollectionViewItem : NSCollectionViewItem

@property (weak) IBOutlet NSTextField * soundTitle;


@end
