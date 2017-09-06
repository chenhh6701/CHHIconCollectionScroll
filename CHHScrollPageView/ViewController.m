//
//  ViewController.m
//  CHHScrollPageView
//
//  Created by chenhh on 2017/9/5.
//  Copyright © 2017年 chenhh. All rights reserved.
//

#import "ViewController.h"
#import "CHHIconCollectionViewScroll.h"

@interface ViewController ()<CHHIconCollectionViewScrollDelegate>
{
    CHHIconCollectionViewScroll * _scroll;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addviews];
}



- (void) addviews {
    _scroll =  [[CHHIconCollectionViewScroll alloc] initWithFrame:CGRectMake(50, 100, 160, 100)];
    _scroll.delegate = self;
    _scroll.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_scroll];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_scroll reloadIconData];
    
    
}

#pragma mark - CHHIconCollectionViewScrollDelegate

- (NSInteger)numberOfItemsInIconCollectionViewScroll {
    return 15;
}

- (UIView *)iconViewInIconCollectionViewScroll:(NSInteger)index lastIcon:(UIView *)lastView {
    if (!lastView) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        lastView = label;
    }
    ((UILabel *)lastView).text = [NSString stringWithFormat:@"%ld",index];
    return lastView;
}

- (void)didSelectedIconViewInIconCollectionViewScroll:(NSInteger)index {
    NSLog(@"  ************** %ld **************   ",index);
}

@end
