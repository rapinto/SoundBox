//
//  SoundItem.h
//  SoundBox
//
//  Created by rpinto on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundItem : NSObject


@property (nonatomic, strong) NSString * title;


@property (nonatomic, strong) NSString * filePath;


#pragma mark - Public


+ (SoundItem *)soundItemWithTitle:(NSString *)title filePath:(NSString *)filePath;


@end
