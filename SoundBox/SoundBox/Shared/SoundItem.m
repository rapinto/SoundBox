//
//  SoundItem.m
//  SoundBox
//
//  Created by rpinto on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//

#import "SoundItem.h"

@implementation SoundItem


#pragma mark - Public


+ (SoundItem *)soundItemWithTitle:(NSString *)title filePath:(NSString *)filePath soundName:(NSString *)soundName
{
    SoundItem * item = [[SoundItem alloc] init];
    
    item.title = title;
    item.filePath = filePath;
    item.soundName = soundName;
    
    return item;
}


+ (NSMutableArray *)appSoundItems
{
    NSMutableArray * soundItems = [NSMutableArray array];
    
    SoundItem * item = nil;
    NSString * filePath = nil;
    
    filePath = [[NSBundle mainBundle] pathForResource:@"dejapostee" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Déjà posté" filePath:filePath soundName:@"dejapostee"];
    [soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"autopromo" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Autopromo" filePath:filePath soundName:@"autopromo"];
    [soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"issou" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Issou" filePath:filePath soundName:@"issou"];
    [soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"nice" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Nice" filePath:filePath soundName:@"nice"];
    [soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"encoredutravail" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Travail" filePath:filePath soundName:@"encoredutravail"];
    [soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"turkey" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Dindon" filePath:filePath soundName:@"turkey"];
    [soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"ouimessire" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Oui Messire" filePath:filePath soundName:@"ouimessire"];
    [soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"deloquetoi" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Deloque toi" filePath:filePath soundName:@"deloquetoi"];
    [soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"mlleman" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Cindy" filePath:filePath soundName:@"mlleman"];
    [soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"joe" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"J'en veux" filePath:filePath soundName:@"joe"];
    [soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"pasdefatigue" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Fatigue" filePath:filePath soundName:@"pasdefatigue"];
    [soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"cestpasfaux" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"C pas faux" filePath:filePath soundName:@"cestpasfaux"];
    [soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"baptiste" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Baptiste" filePath:filePath soundName:@"baptiste"];
    [soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"onenagros" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Y'en a Gros" filePath:filePath soundName:@"onenagros"];
    [soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"lecode" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Le code" filePath:filePath soundName:@"lecode"];
    [soundItems addObject:item];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"IZI" ofType:@"wav"];
    item = [SoundItem soundItemWithTitle:@"Easy" filePath:filePath soundName:@"IZI"];
    [soundItems addObject:item];
    
    return soundItems;
}


@end
