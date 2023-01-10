//
//  MainModel.m
//  计算器
//
//  Created by 翟旭博 on 2022/9/26.
//

#import "MainModel.h"

@implementation MainModel

//计算结果
- (double)Count:(double)x :(char)ch :(double)y {
    if (ch == '+')
        return x + y;
    else if(ch == '-')
        return x - y;
    else if(ch == '*')
        return 1.0 * x * y;
    else if(ch == '/')
        return 1.0 * x / y;
    else
        return -1;
}

- (NSString *)transform:(const char *)arr {
    int i;
    if (arr[strlen(arr) - 1] == '+' || arr[strlen(arr) - 1] == '-' || arr[strlen(arr) - 1] == '*' || arr[strlen(arr) - 1] == '/') {
        NSString *errorstring = [NSString stringWithFormat:@"error"];
        return errorstring;
    }
    
    int leftbrackets = 0, rightbrackets = 0;
    
    for (i = 0; i < strlen(arr); i++) {
        if (arr[i] == '(' && arr[i + 1] == ')') {
            NSString *errorstring = [NSString stringWithFormat:@"error"];
            return errorstring;
        }
        if ((arr[i] == '(' && (arr[i + 1] == '*' || arr[i + 1] == '/')) || ((arr[i] == ')') && ((arr[i - 1] == '+') || (arr[i - 1] == '-') || (arr[i - 1] == '*') || (arr[i - 1] == '/')))) {
            NSString *errorstring = [NSString stringWithFormat:@"error"];
            return errorstring;
        }
        if ((arr[i] == '(' && (arr[i - 1] <= '9' && arr[i - 1] >= '0'))||(arr[i] == ')' && (arr[i + 1] <= '9' && arr[i + 1] >= '0'))) {
            NSString *errorstring = [NSString stringWithFormat:@"error"];
            return errorstring;
        }
        if (arr[i] == '(') {
            leftbrackets++;
        } else if (arr[i] == ')') {
            rightbrackets++;
        }
    }
    if (leftbrackets != rightbrackets) {
        NSString *errorstring = [NSString stringWithFormat:@"error"];
        return errorstring;
    }
    double x = 0.0;
    int flag = 0;
    int f = 0;
    double numStack[1000];
    int numTop = -1;
    char symbolStack[100];
    int symbolTop = -1;
    int dian = 0;
    for (i = 0; i < strlen(arr); i++) {
        if ((arr[i] >= '0' && arr[i] <= '9') || arr[i] == '.') {
            if (arr[i] == '.') {
                dian = 1;
                continue;
            }
            if (dian == 0) {
                x = x * 10 + (arr[i] - '0');
                flag = 1;
            } else {
                x = x + (arr[i] - '0') * pow(0.1, dian);
                //flag = 1;
                dian++;
            }
            
        } else {
            if (flag == 1) {
                if (f == 1) {
                    x = (-1) * x;
                    f = 0;
                }
                numStack[++numTop] = x;
                //NSLog(@"%lf niubi",x);
                x = 0;
                flag = 0;
            }
            if (arr[i] == '(' || arr[i] == '*' || arr[i] == '/') {
                if ((arr[i] == '*' || arr[i] == '/') && (symbolStack[symbolTop] == '*' || symbolStack[symbolTop] == '/')) {
                    numStack[numTop-1] = [self Count:numStack[numTop-1] :symbolStack[symbolTop] :numStack[numTop]];
                    numTop--;
                    symbolTop--;
                }
                symbolStack[++symbolTop] = arr[i];
            }
            if (arr[i] == ')') {
                while (symbolStack[symbolTop] != '(') {
                    numStack[numTop - 1] = [self Count:numStack[numTop - 1] :symbolStack[symbolTop] :numStack[numTop]];
                    numTop--;
                    symbolTop--;
                }
                if (symbolStack[symbolTop] == '(') {
                    symbolTop = symbolTop - 1;
                }
            }
            if (arr[i] == '+' || (arr[i] == '-' && arr[i - 1] != '(')) {
                if ((arr[i] == '+' || arr[i] == '-') && (symbolStack[symbolTop] == '+' || symbolStack[symbolTop] == '-')) {
                    numStack[numTop-1] = [self Count:numStack[numTop-1] :symbolStack[symbolTop] :numStack[numTop]];
                    numTop--;
                    symbolTop--;
                }
                if ((symbolStack[symbolTop] != '*' && symbolStack[symbolTop]!='/') || symbolTop == -1) {
                    symbolStack[++symbolTop] = arr[i];
                } else {
                    numStack[numTop - 1] = [self Count:numStack[numTop-1] :symbolStack[symbolTop] :numStack[numTop]];
                    
                    NSLog(@"%f %c %f",numStack[numTop-1] ,symbolStack[symbolTop] ,numStack[numTop]);
                    numTop--;
                    symbolTop--;
                    i = i - 1;
                }
            }
            if (arr[i] == '-' && arr[i-1] == '(') {
                f = 1;
            }
            dian = 0;
        }
        
    }
    if (arr[strlen(arr)-1] >= '0' && arr[strlen(arr)-1] <= '9') {
        numStack[++numTop]=x;
    }
    while (symbolTop != -1) {
        numStack[numTop - 1] = [self Count:numStack[numTop-1] :symbolStack[symbolTop] :numStack[numTop]];
        //NSLog(@"%f %c %f %d %d",numStack[numTop-1] ,symbolStack[symbolTop] ,numStack[numTop],numTop,symbolTop);
        numTop--;
        symbolTop--;
    }
    NSString *string = [NSString stringWithFormat:@"%.6f", numStack[numTop]];
    //NSLog(@"%@",string);
    return string;
}
@end
