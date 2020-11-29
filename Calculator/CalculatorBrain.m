//
//  CalculatorBrain.m
//  Calculator
//
//  Created by 岡川 宏 on 11/11/06.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain

@synthesize operand;
@synthesize memoryOperand;
@synthesize isRadian;
@synthesize alertText;

- (NSString *)waitingOperation
{
    if (waitingOperation && ![waitingOperation isEqual:@"="]) {
        return [NSString stringWithFormat:@"%g %@", waitingOperand, waitingOperation];
    } else {
        return @"";
    }
}

- (void)performWaitingOperation
{
    if ([@"+" isEqual:waitingOperation]) {
        operand = waitingOperand + operand;
    } else if ([@"-" isEqual:waitingOperation]) {
        operand = waitingOperand - operand;
    } else if ([@"*" isEqual:waitingOperation]) {
        operand = waitingOperand * operand;
    } else if ([@"/" isEqual:waitingOperation]) {
        if (operand) {
            operand = waitingOperand / operand;
        } else {
            alertText = @"Division by zero";
        }
    }
}

- (double)performOperation:(NSString *)operation
{
    alertText = @"No alert";

    if([operation isEqual:@"store"]){
        memoryOperand = operand;
    } else if([operation isEqual:@"recall"]){
        operand = memoryOperand;
        waitingOperation = nil;
        waitingOperand = 0.0;
    } else if([operation isEqual:@"mem+"]) {
        memoryOperand += operand;
    } else if ([operation isEqual:@"clear"]) {
        memoryOperand = 0;
    } else if ([operation isEqual:@"sqrt"]) {
        operand = sqrt(operand);
    } else if ([operation isEqual:@"1/x"]) {
        waitingOperation = @"/";
        waitingOperand = 1.0;
        [self performWaitingOperation];

        waitingOperation = nil;
        waitingOperand = 0.0;
    } else if ([operation isEqual:@"+/-"]) {
        operand = -operand;
    } else if ([operation isEqual:@"sin"]) {
        if (!isRadian) {
            operand = M_PI * operand / 180;
        }
        operand = sin(operand);
    } else if ([operation isEqual:@"cos"]) {
        if (!isRadian) {
            operand = M_PI * operand / 180;
        }
        operand = cos(operand);
    } else if ([operation isEqual:@"Pi"]) {
        operand = atan(1)*4;
    } else if ([operation isEqual:@"C"]) {
        operand = 0.0;
        memoryOperand = 0.0;
        waitingOperation = nil;
        waitingOperand = 0.0;
    } else {
        [self performWaitingOperation];
        waitingOperation = operation;
        waitingOperand = operand;
    }
    return operand;
}

@end
