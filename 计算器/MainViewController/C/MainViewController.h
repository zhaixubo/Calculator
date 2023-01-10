//
//  MainViewController.h
//  计算器
//
//  Created by 翟旭博 on 2022/9/26.
//

#import "ViewController.h"
#import "MainModel.h"
#import "MainView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : ViewController <buttondelegate>

@property (nonatomic, strong) MainView *mainview;
@property (nonatomic, strong) MainModel *mainmodel;
@property (nonatomic, strong) NSMutableArray *MainArray;
@property (nonatomic, strong) NSMutableString *MainString;

@end

NS_ASSUME_NONNULL_END
