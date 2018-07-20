//
//  SoundCollectionViewItem.m
//  SoundBoxMac
//
//  Created by julien gimenez on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//

#import "SoundCollectionViewItem.h"

@interface SoundCollectionViewItem ()

@end

@implementation SoundCollectionViewItem


- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)setRepresentedObject:(id)representedObject
{
    if (representedObject != nil)
    {
        [self.soundTitle setStringValue:[representedObject valueForKey:@"itemTitle"]];
    }
}


@end
