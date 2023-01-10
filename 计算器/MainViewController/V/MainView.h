//
//  MainView.h
//  计算器
//
//  Created by 翟旭博 on 2022/9/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol buttondelegate <NSObject>

- (void)Chubutton:(UIButton *)button;

@end

@interface MainView : UIView

@property (nonatomic, strong) UIButton *smallbutton;
@property (nonatomic, strong) NSArray *orangearray;
@property (nonatomic, strong) NSArray *firstarray;
@property (nonatomic, strong) UILabel *label;

@property (assign, nonatomic) id<buttondelegate> delegate;
@end

NS_ASSUME_NONNULL_END
