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


+ (SoundItem *)soundItemWithTitle:(NSString *)title filePath:(NSString *)filePath
{
    SoundItem * item = [[SoundItem alloc] init];
    
    item.title = title;
    item.filePath = filePath;
    
    return item;
}


@end
