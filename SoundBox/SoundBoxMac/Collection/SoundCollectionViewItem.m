//
//  SoundCollectionViewItem.m
//  SoundBoxMac
//
//  Created by julien gimenez on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//

#import "SoundCollectionViewItem.h"

#import <AVFoundation/AVFoundation.h>
#import "SoundItem.h"


NSString * const SoundCollectionViewItem_Identifier = @"SoundCollectionViewItem_Identifier";

@interface SoundCollectionViewItem () <AVAudioPlayerDelegate>


@property (nonatomic,strong) AVAudioPlayer * player;


@property (nonatomic,strong) SoundItem * currentItem;


@end

@implementation SoundCollectionViewItem


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = NSColor.lightGrayColor.CGColor;
}


- (void)setRepresentedObject:(id)representedObject
{
    if (representedObject != nil && [representedObject isKindOfClass:[SoundItem class]])
    {
        self.currentItem = (SoundItem *)representedObject;
        
        [self.soundTitle setStringValue:self.currentItem.title];
    }
}


- (IBAction)play:(id)sender
{    
    NSURL *soundFileURL = [NSURL fileURLWithPath:self.currentItem.filePath];
    
    NSError *error;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                         error:&error];
    self.player.numberOfLoops = 0;
    self.player.delegate  = self;
    [self.player play];
}


#pragma mark - AVAudio Player


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    self.player = nil;
    self.currentItem = nil;
}


@end
