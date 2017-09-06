//
//  CHHIconCollectionView.h
//  CHHScrollPageView
//
//  Created by chenhh on 2017/9/5.
//  Copyright © 2017年 chenhh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CHHIconCollectionViewSubViewOrientation) {
    CHHIconCollectionViewSubViewOrientationHorizontal,      // 水平方向
    CHHIconCollectionViewSubViewOrientationVertical         // 垂直方向
};



@protocol CHHIconCollectionViewDelegate;
@interface CHHIconCollectionView : UIView

@property (weak,nonatomic) id<CHHIconCollectionViewDelegate> delegate;

- (void)reloadOneSubView:(NSInteger) index;

- (void)reloatAllSubView ;
@end

@protocol CHHIconCollectionViewDelegate <NSObject>

- (UIView *)iconCollectionView:(CHHIconCollectionView *)iconCollectionView containedViewInSubView:(NSInteger)index containedView:(UIView *)lastView;

- (void)iconCollectionView:(CHHIconCollectionView *)iconCollectionView didSelectedSubViewInCollection:(NSInteger) index;

@end
