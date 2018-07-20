//
//  TodayViewController.h
//  Widget
//
//  Created by rpinto on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface TodayViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end
