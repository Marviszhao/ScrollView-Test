//
//  ViewController.m
//  ScrollViewTest
//
//  Created by MARVIS on 2017/2/7.
//  Copyright © 2017年 MARVIS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scorllView;

@property (nonatomic, weak) IBOutlet UILabel *testLab;

@property (nonatomic, assign) CGPoint startPoint;

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *View1WidthCon;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchTopCon;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startPoint = CGPointMake(0, -10000);
    self.isShow = YES;
}

- (void)setIsShow:(BOOL)isShow{
    if (isShow == _isShow) {
        return;
    }
    _isShow = isShow;
    [self showSearchBar:_isShow];
}

- (void)showSearchBar:(BOOL )isShow{
    self.searchTopCon.constant = -44;
    if (isShow == YES) {
        self.searchTopCon.constant = 20;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

#pragma mark - UIScrollViewDelegate
#pragma mark - 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"contentOffset-----------%@",NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat distance = scrollView.contentOffset.y - self.startPoint.y;
    
    if (fabs(distance) > 10) {
        if (self.isShow == NO && distance < 0) {
            NSLog(@"出现动画");
            self.testLab.text = @"出现";
            self.isShow = YES;
        }
        
        if (self.isShow == YES && distance > 0 && self.startPoint.y >= 0) {
            NSLog(@"消失动画");
            self.testLab.text = @"隐藏";
            self.isShow = NO;
        }
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"scrollViewWillBeginDragging-----contentOffset:%@",NSStringFromCGPoint(scrollView.contentOffset));
    self.startPoint = scrollView.contentOffset;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"scrollViewWillEndDragging-----velocity:%@,targetContentOffset:%@",NSStringFromCGPoint(velocity),NSStringFromCGPoint(*targetContentOffset));
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"scrollViewDidEndDragging-----contentOffset:%@",NSStringFromCGPoint(scrollView.contentOffset));
    
    CGFloat distance = scrollView.contentOffset.y - self.startPoint.y;
    if (self.isShow == YES && distance > 4 && self.startPoint.y >= 0) {
        NSLog(@"消失动画");
        self.testLab.text = @"隐藏";
        self.isShow = NO;
    }
    self.startPoint = CGPointMake(0, -10000);
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    
}


@end
