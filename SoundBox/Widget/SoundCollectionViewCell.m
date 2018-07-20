//
//  SoundCollectionViewCell.m
//  Widget
//
//  Created by rpinto on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//


#import "SoundCollectionViewCell.h"
#import "SoundItem.h"


NSString * const SoundCollectionViewCell_Identifier = @"SoundCollectionViewCell";


@implementation SoundCollectionViewCell


#pragma mark - Public


- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.playIcon.image = nil;
    self.soundTitleLabel.text = nil;
}


#pragma mark - Public


- (void)updateWithSoundItem:(SoundItem *)soundItem isPlaying:(BOOL)isPlaying
{
    if (isPlaying)
    {
        self.playIcon.image = [UIImage imageNamed:@"stop.png"];
    }
    else
    {
        self.playIcon.image = [UIImage imageNamed:@"play.png"];
    }
    
    
    self.soundTitleLabel.text = soundItem.title;
}


@end
