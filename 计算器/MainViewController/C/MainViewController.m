//
//  MainViewController.m
//  计算器
//
//  Created by 翟旭博 on 2022/9/26.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.mainview = [[MainView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview: self.mainview];
    self.mainview.delegate = self;
    self.mainmodel = [[MainModel alloc] init];
    
    _MainArray = [[NSMutableArray alloc]init];
    _MainString = [[NSMutableString alloc] init];
    
    

}

// 记录小数点状态
int pointFlag = 0;
// 防止连续输入符号
int secondFlag = 0;
// 记录等于号状态
int equalFlag = 0;
// 记录数字后再输入小数点
int numpoint = 0;
//记录左括号数量
int leftbrackets = 0;


- (void)Chubutton:(UIButton *)button {
    //NSLog(@"%ld",(long)button.tag);
    if (button.tag == 17) { //AC
        //[_MainArray removeAllObjects];
        _MainString = nil;
        _MainString = [[NSMutableString alloc] init];
        self.mainview.label.text = @"0";
        pointFlag = 0;
        secondFlag = 0;
        equalFlag = 0;
        leftbrackets = 0;
    } else if (button.tag == 1) { //0
       // [_MainArray addObject:button.titleLabel.text];
        [_MainString appendString:button.titleLabel.text];
        self.mainview.label.text = _MainString;
        secondFlag = 0;
        numpoint = 0;
    } else if ((button.tag <= 7 && button.tag >= 5) || (button.tag <= 11 && button.tag >= 9) || (button.tag <= 15 && button.tag >= 13)) { //9个数字
        //[_MainArray addObject:button.titleLabel.text];
        [_MainString appendString:button.titleLabel.text];
        self.mainview.label.text = _MainString;
        secondFlag = 0;
        numpoint = 0;
    } else if (button.tag == 3) { //小数点
        if (numpoint == 0 && pointFlag == 0) {
            //[_MainArray addObject:button.titleLabel.text];
            [_MainString appendString:button.titleLabel.text];
            self.mainview.label.text = _MainString;
            pointFlag = 1;
        } else {
            
        }
    } else if (button.tag == 20 || button.tag == 8 || button.tag == 12 || button.tag == 16) { //四个运算符
        if (secondFlag == 0) {
            pointFlag = 0;
            secondFlag = 1;
            numpoint = 1;
            //[_MainArray addObject:button.titleLabel.text];
            [_MainString appendString:button.titleLabel.text];
            self.mainview.label.text = _MainString;
        } else {
            
        }
    } else if (button.tag == 4) { //等号
        //[_MainArray addObject:button.titleLabel.text];
        //[_MainString appendString:button.titleLabel.text];
        
        self.mainview.label.text = _MainString;
        [_MainString replaceOccurrencesOfString:@")(" withString:@")*(" options:NSLiteralSearch range:NSMakeRange(0, [_MainString length])];
        const char *cstring = [_MainString UTF8String];
        
        NSMutableString *newstring = [NSMutableString stringWithFormat:@"%@", [self.mainmodel transform:cstring]];
        NSLog(@"%@",newstring);
        if ([newstring isEqualToString:@"error"] || [newstring isEqualToString:@"inf"]) {
            newstring = [NSMutableString stringWithFormat:@"error"];
        } else {
            newstring = [NSMutableString stringWithFormat:@"%@", @(newstring.floatValue)];
            
        }
        
        NSLog(@"%@",newstring);
        self.mainview.label.text = newstring;
        _MainString = nil;
        _MainString = [[NSMutableString alloc] init];
        if ([newstring isEqualToString:@"error"] || [newstring isEqualToString:@"inf"]) {
            
        } else {
            [_MainString appendString:newstring];
        }
      
        pointFlag = 0;
        secondFlag = 0;
        equalFlag = 0;
        leftbrackets = 0;
    } else if (button.tag == 18) { //左
       // [_MainArray addObject:button.titleLabel.text];
        leftbrackets++;
        [_MainString appendString:button.titleLabel.text];
        self.mainview.label.text = _MainString;
        secondFlag = 0;
    } else if (button.tag == 19) { //右
        //[_MainArray addObject:button.titleLabel.text];
        if (leftbrackets != 0) {
            [_MainString appendString:button.titleLabel.text];
            self.mainview.label.text = _MainString;
            leftbrackets--;
        } else {
            
        }
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
