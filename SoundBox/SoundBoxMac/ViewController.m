//
//  ViewController.m
//  SoundBoxMac
//
//  Created by julien gimenez on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "ViewController.h"
#import "SoundItem.h"


@interface ViewController() <AVAudioPlayerDelegate>


@property (nonatomic,strong) AVAudioPlayer * player;
    
@property (nonatomic,strong) NSMutableArray * soundItems;


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)play:(id)sender
{
    SoundItem * item = [self.soundItems objectAtIndex:0];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:item.filePath];
    
    NSError *error;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                         error:&error];
    self.player.numberOfLoops = 0; //Infinite
    self.player.delegate  = self;
    [self.player play];
}


#pragma mark - AVAudio Player


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    self.player = nil;
}

@end
