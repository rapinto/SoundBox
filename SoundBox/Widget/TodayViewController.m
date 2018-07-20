//
//  TodayViewController.m
//  Widget
//
//  Created by rpinto on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>


static const CGSize maxCompactSize = {320, 60};
static const CGSize maxExpandedSize = {320, 400};


@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.extensionContext setWidgetLargestAvailableDisplayMode:NCWidgetDisplayModeExpanded];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}


- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    NSLog(@"activeDisplayMode %lu with maxSize %@", activeDisplayMode, [NSValue valueWithCGSize:maxSize]);
    if (activeDisplayMode == NCWidgetDisplayModeCompact)
    {
        [self updateToWidgetCompactMode];
        self.preferredContentSize = maxCompactSize;
    }
    else if (activeDisplayMode == NCWidgetDisplayModeExpanded)
    {
        [self updateToWidgetExpandedMode];
        self.preferredContentSize = maxExpandedSize;
    }
}


- (CGSize)widgetMaximumSizeForDisplayMode:(NCWidgetDisplayMode)displayMode
{
    NSLog(@"activeDisplayMode %lu", displayMode);
    if (displayMode == NCWidgetDisplayModeCompact)
    {
        return maxCompactSize;
    }
    else if (displayMode == NCWidgetDisplayModeExpanded)
    {
        return maxExpandedSize;
    }
    
    return CGSizeZero;
}


#pragma mark - Private


- (void)updateToWidgetCompactMode
{
    NSLog(@"updateToWidgetCompactMode");
    
    self.view.backgroundColor = [UIColor redColor];
}


- (void)updateToWidgetExpandedMode
{
    NSLog(@"updateToWidgetExpandedMode");
    
    self.view.backgroundColor = [UIColor blueColor];
}


#pragma mark - CollectionView


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.extensionContext.widgetActiveDisplayMode == NCWidgetDisplayModeCompact)
    {
        return 4;
    }
    else
    {
        return 16;
    }
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
