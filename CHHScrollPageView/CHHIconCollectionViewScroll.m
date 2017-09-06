//
//  CHHIconCollectionViewScroll.m
//  CHHScrollPageView
//
//  Created by chenhh on 2017/9/6.
//  Copyright © 2017年 chenhh. All rights reserved.
//

#import "CHHIconCollectionViewScroll.h"

#import "CHHIconCollectionView.h"


static NSInteger const CHHICVSCollectionViewTag = 9630;

static NSInteger const CHHICVSSubViewLargestNumber = 5;

@interface CHHIconCollectionViewScroll () <CHHIconCollectionViewDelegate,UIScrollViewDelegate>


@property (strong,nonatomic) UIScrollView *scrollView;



@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong,nonatomic) NSArray<CHHIconCollectionView *> *iconCollectionViewArr;


@end


@implementation CHHIconCollectionViewScroll


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self  addviews];
    }
    
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self  addviews];
    }
    
    return self;
}

#pragma mark - property
/// View

- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if(!_pageControl) {
        
        _pageControl  =  [[UIPageControl alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) / 2.0 - 40 ,CGRectGetHeight( self.frame ) - 20, 80, 20)];
        [self addSubview:_pageControl];
        
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    }
    return _pageControl;
}

// 添加View
- (void)addviews {
    
    //UIScrollView
    
    //1.设置尺寸
    
    CGFloat scrollWidth=self.scrollView.frame.size.width;
    
    CGFloat scrollHeight=self.scrollView.frame.size.height;

    //2.添加轮播
    NSMutableArray<CHHIconCollectionView *> *tempArr = [[NSMutableArray alloc] init];
    for (int i=0; i<CHHICVSSubViewLargestNumber; i++) {
        
        CHHIconCollectionView *subCollectionView=[[CHHIconCollectionView alloc]init];
        subCollectionView.frame=CGRectMake(scrollWidth*i, 0, scrollWidth, scrollHeight - 20);
        subCollectionView.tag = CHHICVSCollectionViewTag + i;
        subCollectionView.delegate = self;
        
        [self.scrollView addSubview:subCollectionView];
        [tempArr addObject:subCollectionView];
    }
    _iconCollectionViewArr = tempArr;
    
    //3.设置滚动样式
    
    //滚动高度设定为零时在垂直方向无法滚动
    
    self.scrollView.contentSize=CGSizeMake(scrollWidth*CHHICVSSubViewLargestNumber, 0);
    
    //开启分页功能
    
    self.scrollView.pagingEnabled=YES;
    
    //隐藏提示条
    
    self.scrollView.showsHorizontalScrollIndicator=NO;
    
    //4.UIPageControl
    
    self.pageControl.hidesForSinglePage=YES;
    
    self.pageControl.numberOfPages = CHHICVSSubViewLargestNumber;
    
    self.pageControl.userInteractionEnabled = NO;
    
    //[self.pageControl setValue:[UIImage imageNamed:@"current"] forKey:@"_currentPageImage"];
    
    //[self.pageControl setValue:[UIImage imageNamed:@"other"] forKey:@"_pageImage"];

    //5.设置scrollView的代理
    
    self.scrollView.delegate=self;
}


//下一页

-(void)nextPage

{
    NSInteger page=self.pageControl.currentPage+1;
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*page, 0) animated:YES];
    
    NSLog(@"%zd",page);
    
}

// 刷新
- (void) reloadIconData{
    
    CGFloat scrollWidth=self.scrollView.frame.size.width;
    NSInteger count = 0;
    if(_delegate) {
        NSInteger number = [_delegate numberOfItemsInIconCollectionViewScroll];
        count = (number % 10 == 0)?number/10:number/10 +1;
        
    }
    self.scrollView.contentSize=CGSizeMake(scrollWidth*count, 0);
    self.pageControl.numberOfPages = count;
    
    for (CHHIconCollectionView *iconCollectionView  in _iconCollectionViewArr) {
        [iconCollectionView reloatAllSubView];
    }
    
}

- (void)reloadOneIconInData:(NSInteger)index {
    NSInteger viewTag = index/10;
      CHHIconCollectionView *iconCollectionView = _iconCollectionViewArr[viewTag];

    [iconCollectionView  reloadOneSubView:(viewTag % 10)];
    
}


#pragma mark - UIScrollViewDelegate


//只要滚动就会调用

-(void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    
    int page=(int)(scrollView.contentOffset.x/scrollView.frame.size.width);

    self.pageControl.currentPage = page;

}


#pragma mark - CHHIconCollectionViewDelegate

- (UIView *)iconCollectionView:(CHHIconCollectionView *)iconCollectionView containedViewInSubView:(NSInteger)index containedView:(UIView *)lastView {
    
    NSInteger collectionIndex = iconCollectionView.tag % CHHICVSCollectionViewTag;
    
    NSInteger realIndex = collectionIndex * 10 + index;

    if(_delegate && realIndex < [_delegate numberOfItemsInIconCollectionViewScroll] ) {
        
        return [_delegate iconViewInIconCollectionViewScroll:realIndex lastIcon:lastView];
    } else {
        // 去除残留
        if(lastView) {
            [lastView removeFromSuperview];
            lastView = nil;
        }

         return nil;
    }

}

- (void)iconCollectionView:(CHHIconCollectionView *)iconCollectionView didSelectedSubViewInCollection:(NSInteger) index {
    
    NSInteger collectionIndex = iconCollectionView.tag % CHHICVSCollectionViewTag;
    
    NSInteger realIndex = collectionIndex * 10 + index;
    
    if(_delegate && realIndex < [_delegate numberOfItemsInIconCollectionViewScroll]) {
        [_delegate didSelectedIconViewInIconCollectionViewScroll:realIndex];
    }
    
    
}

@end
