//
//  SoundCollectionViewCell.h
//  Widget
//
//  Created by rpinto on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SoundItem;


extern NSString * const SoundCollectionViewCell_Identifier;


@interface SoundCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UILabel *soundTitleLabel;


@property (weak, nonatomic) IBOutlet UIImageView *playIcon;


#pragma mark - Public


- (void)updateWithSoundItem:(SoundItem *)soundItem isPlaying:(BOOL)isPlaying;


@end
