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


#pragma mark - Cocoa


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
        
        if (self.currentItem.title)
        {
            [self.soundTitle setStringValue:self.currentItem.title];
        }
        else
        {
            [self.soundTitle setStringValue:@"Catastrophe"];
        }
    }
}


#pragma mark - Private


- (IBAction)playAction:(id)sender
{
    NSURL * url = nil;
    
    if (self.currentItem.filePath)
    {
        url = [NSURL fileURLWithPath:self.currentItem.filePath];
    }
    else
    {
        url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"turkey" ofType:@"wav"]];
    }
    
    [self playURL:url];
}


- (void)playURL:(NSURL *)url
{
    NSError *error;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                         error:&error];
    self.player.numberOfLoops = 0;
    self.player.delegate  = self;
    [self.player play];
}


#pragma mark - AVAudio Player


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    self.player = nil;
}


@end
