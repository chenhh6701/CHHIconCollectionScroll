//
//  CHHIconCollectionViewScroll.h
//  CHHScrollPageView
//
//  Created by chenhh on 2017/9/6.
//  Copyright © 2017年 chenhh. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CHHIconCollectionViewScrollDelegate;

@interface CHHIconCollectionViewScroll : UIView

@property (weak,nonatomic) id<CHHIconCollectionViewScrollDelegate> delegate;

// 刷新
- (void)reloadIconData;

- (void)reloadOneIconInData:(NSInteger) index;

@end

@protocol CHHIconCollectionViewScrollDelegate <NSObject>


/**
 data的数据大小

 @return item的个数
 */
- (NSInteger)numberOfItemsInIconCollectionViewScroll;

/**
 index的View

 @param index data中的index
 @param lastView 上次遗留的view（复用），可能为nil
 @return view
 */
- (UIView *)iconViewInIconCollectionViewScroll:(NSInteger)index lastIcon:(UIView *)lastView;

/**
 Icon点击事件

 @param index icon在data中的index
 */
- (void)didSelectedIconViewInIconCollectionViewScroll:(NSInteger)index;

@end
