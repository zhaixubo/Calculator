//
//  MainView.m
//  计算器
//
//  Created by 翟旭博 on 2022/9/26.
//

#import "MainView.h"
#import "Masonry.h"
#define smallWidth (([UIScreen mainScreen].bounds.size.width - 13) / 4 - 13)
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@implementation MainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor blackColor];
    _firstarray = [NSArray arrayWithObjects:@"0", @"0", @"0", @".", @"=", @"1", @"2", @"3", @"+", @"4", @"5", @"6" , @"-", @"7", @"8", @"9", @"*", @"AC", @"(", @")", @"/", nil];
    
    _label = [[UILabel alloc] init];
    _label.backgroundColor = [UIColor blackColor];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentRight;
    _label.text = @"0";
    _label.font = [UIFont systemFontOfSize:0.15 * Width];
    [self addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker* make) {
        make.bottom.equalTo(self).offset(-((smallWidth + 13) * (5 + 1)) + 20);
        make.left.equalTo(self).offset(13 + (smallWidth + 13) * 0);
        make.width.equalTo(@(Width - 26));
        make.height.equalTo(@smallWidth);
    }];
    
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 4; j++) {
            _smallbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _smallbutton.titleLabel.font = [UIFont systemFontOfSize:0.115 * Width];
            _smallbutton.tintColor = [UIColor whiteColor];
            if (i == 4 && j <= 2) {
                _smallbutton.titleLabel.font = [UIFont systemFontOfSize:Width * 0.1];
                _smallbutton.tintColor = [UIColor blackColor];
            }
            _smallbutton.layer.cornerRadius = smallWidth / 2;
            
            [self addSubview:_smallbutton];
            if ((i == 0 && j == 0) || (i == 0 && j == 1)) {
                continue;
            } else {
                _smallbutton.tag = i * 4 + j + 1;
                [_smallbutton mas_makeConstraints:^(MASConstraintMaker* make) {
                    make.bottom.equalTo(self).offset(-((smallWidth + 13) * (i + 1)) + 40);
                    make.left.equalTo(self).offset(13 + (smallWidth + 13) * j);
                    make.width.equalTo(@smallWidth);
                    make.height.equalTo(@smallWidth);
                }];

            }
            if (i >= 0 && i < 4 && j < 3) {
                [_smallbutton setBackgroundColor:[UIColor colorWithRed:(85.0f / 256.0f) green:(85.0f / 256.0f) blue:(85.0f / 256.0f) alpha:1]];
            } else if (j == 3) {
                [_smallbutton setBackgroundColor:[UIColor colorWithRed:(239.0f / 256.0f) green:(143.0f / 256.0f) blue:(50.0f / 256.0f) alpha:1]];
            } else {
                [_smallbutton setBackgroundColor:[UIColor colorWithRed:(170.0f / 256.0f) green:(170.0f / 256.0f) blue:(170.0f / 256.0f) alpha:1]];
            }
            [_smallbutton setTitle:_firstarray[_smallbutton.tag] forState:UIControlStateNormal];
            [_smallbutton addTarget:self action:@selector(buttonreturn:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    _smallbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _smallbutton.layer.cornerRadius = smallWidth / 2;
    _smallbutton.tintColor = [UIColor whiteColor];
    [self addSubview:_smallbutton];
    _smallbutton.tag = 1;
    [_smallbutton mas_makeConstraints:^(MASConstraintMaker* make) {
        make.bottom.equalTo(self).offset(-((smallWidth + 13) * (0 + 1)) + 40);
        make.left.equalTo(self).offset(13 + (smallWidth + 13) * 0);
        make.width.equalTo(@(smallWidth * 2 + 13));
        make.height.equalTo(@smallWidth);
    }];
    [_smallbutton setBackgroundColor:[UIColor colorWithRed:(85.0f / 256.0f) green:(85.0f / 256.0f) blue:(85.0f / 256.0f) alpha:1]];
    _smallbutton.titleLabel.font = [UIFont systemFontOfSize:0.115 * Width];
    [_smallbutton setTitle:_firstarray[_smallbutton.tag] forState:UIControlStateNormal];
    [_smallbutton addTarget:self action:@selector(buttonreturn:) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (void)buttonreturn:(UIButton *)button {
    [_delegate Chubutton:button];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
