//
//  CalculatorBrain.h
//  Calculator
//
//  Created by 岡川 宏 on 11/11/06.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject {
@private
    double operand;
    double memoryOperand;
    double waitingOperand;
    BOOL   isRadian;
    NSString *alertText;
    NSString *waitingOperation;
}

@property double operand;
@property double memoryOperand;
@property BOOL isRadian;
@property (copy) NSString *alertText;
@property (copy,readonly) NSString *waitingOperation;
- (double)performOperation:(NSString *)operation;


@end
