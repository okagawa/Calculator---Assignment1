//
//  ViewController.h
//  Calculator
//
//  Created by 岡川 宏 on 11/11/06.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface ViewController : UIViewController {
@private
    IBOutlet UILabel *display;
    IBOutlet UILabel *alertLabel;
    IBOutlet UILabel *memoryDisplay;
    IBOutlet UILabel *waitingDisplay;
    CalculatorBrain *brain;
    BOOL userIsInTheMiddleOfTypingANumber;
    IBOutlet UISwitch *radianSw;
}

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
- (IBAction)radianSwPressed:(id)sender;

@end
