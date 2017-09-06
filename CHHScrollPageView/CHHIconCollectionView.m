//
//  CHHIconCollectionView.m
//  CHHScrollPageView
//
//  Created by chenhh on 2017/9/5.
//  Copyright © 2017年 chenhh. All rights reserved.
//
//  10个格子，根据中心点
//
//  在frame确定的前提下

#import "CHHIconCollectionView.h"

static NSInteger const CHHICVContainedViewTag = 8757;
static NSInteger const CHHICVContainedViewBaseTag = 6850;

@interface CHHIconCollectionView ()

@property (strong,nonatomic) NSArray<UIView *> *subViewArr;
// CGPointValue
@property (copy,nonatomic) NSArray<NSValue *> *subViewCenterArr;

@end

@implementation CHHIconCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    
    // view排列
    for(int i = 0; i < 10; i++) {
        [self reloadOneSubView:i];
    }
    
    [super layoutSubviews];
}

// 刷新单个SubView
- (void)reloadOneSubView:(NSInteger) index {
    UIView *subView = self.subViewArr[index];
    // 缓存机制
    if(_delegate) {
        UIView *tempView = [subView viewWithTag:CHHICVContainedViewTag];
        UIView *containedView = [_delegate iconCollectionView:self containedViewInSubView:index containedView:tempView];
        // 判断是否是复用
        if(containedView && !containedView.superview) {
            // 不是重新设置frame
            float allWidth = CGRectGetWidth(self.frame);
            float allHeight = CGRectGetHeight(self.frame);
            float containedViewSizeWidth = allWidth / 5.0;
            float containedViewSizeHeight = allHeight / 2.0;
            containedView.center = CGPointMake(containedViewSizeWidth * 0.5, containedViewSizeHeight * 0.5);
            containedView.tag = CHHICVContainedViewTag;
            [subView addSubview:containedView];
        }
    }
}

- (void)reloatAllSubView {
    [self setNeedsLayout];
}


# pragma mark - property

- (NSArray<UIView *> *)subViewArr {
    if(!_subViewArr) {
        
        NSMutableArray *tempArr =  [[NSMutableArray alloc] init];
        for(int i =0; i < 10; i++) {
            [tempArr addObject:[self addContainedSubView:i]];
        }
   
        _subViewArr = tempArr;
    }
    return _subViewArr;
}

- (NSArray<NSValue *> *)subViewCenterArr {
    if (!_subViewCenterArr) {
        
        NSMutableArray *tempArr =  [[NSMutableArray alloc] init];
        
        float allWidth = CGRectGetWidth(self.frame);
        float allHeight = CGRectGetHeight(self.frame);
        
        float containedViewSizeWidth = allWidth / 5.0;
        float containedViewSizeHeight = allHeight / 2.0;
        // 第一排
        for(int i = 0;i < 5; i++) {
            
            NSValue *pointValue = [NSValue valueWithCGPoint:CGPointMake((i + 0.5)*containedViewSizeWidth , containedViewSizeHeight * 0.5)];

            [tempArr addObject:pointValue];
        }
        // 第二排
        for(int i = 0;i < 5; i++) {
            NSValue *pointValue = [NSValue valueWithCGPoint:CGPointMake((i + 0.5)*containedViewSizeWidth , containedViewSizeHeight * 1.5)];
            [tempArr addObject:pointValue];
        }
        
        _subViewCenterArr = tempArr;
    }
    return _subViewCenterArr;
}

# pragma mark - private func

- (UIView *)addContainedSubView:(NSInteger)index {
    // 大小和中心点
    float allWidth = CGRectGetWidth(self.frame);
    float allHeight = CGRectGetHeight(self.frame);
    float containedViewSizeWidth = allWidth / 5.0;
    float containedViewSizeHeight = allHeight / 2.0;
    
    UIButton *subView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, containedViewSizeWidth, containedViewSizeHeight)];
    subView.center = [self.subViewCenterArr[index] CGPointValue];
    subView.tag = CHHICVContainedViewBaseTag + index;
    [subView addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:subView];
    
    return subView;
}

// 点击事件
-(void)btnAction:(UIButton *)btn {

    if(_delegate) {
        [_delegate iconCollectionView:self didSelectedSubViewInCollection: (btn.tag %CHHICVContainedViewBaseTag)];
    }
    
}


@end
