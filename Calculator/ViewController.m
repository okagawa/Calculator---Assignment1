//
//  ViewController.m
//  Calculator
//
//  Created by 岡川 宏 on 11/11/06.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (readonly) CalculatorBrain *brain;
@end

@implementation ViewController

// lazyなインスタンス化
- (CalculatorBrain *)brain
{
    if (!brain) {
        brain = [[CalculatorBrain alloc] init];
        brain.isRadian = YES;
    }
    return brain;
}

- (bool)isFloatNumber:(NSString *)digits
{
    NSRange period = [digits rangeOfString:@"."];
    if( period.location != NSNotFound ) {
        return YES;
    } else {
        return NO;
    }
}


- (IBAction)digitPressed:(UIButton *)sender
{
    // NSString *digit = [[sender titleLabel] text];
    NSString *digit = sender.titleLabel.text;
    if (userIsInTheMiddleOfTypingANumber) {
        if ([@"0" isEqual:display.text] && ![@"." isEqual:digit]) {
            display.text = digit;
        } else {
            if (!([@"." isEqual:digit] && [self isFloatNumber:display.text])) {
                display.text = [display.text stringByAppendingString:digit];
            }
        }
    } else {
        display.text = digit;
        userIsInTheMiddleOfTypingANumber = YES;
    }
    alertLabel.text = @"No alert";
}

- (IBAction)operationPressed:(UIButton *)sender
{
    NSString *operation = sender.titleLabel.text;
    
    if ([@"BS" isEqual:operation]) {
        int len = [display.text length];
        if (len > 1 ) {
            display.text = [display.text substringToIndex:(len-1)];
        } else {
            display.text = @"0";
        }
    } else if ([@"clear" isEqual:operation]) {
        [self.brain performOperation:operation];
        memoryDisplay.text = [NSString stringWithFormat:@"%g", self.brain.memoryOperand];
        alertLabel.text = self.brain.alertText;
    } else {
        if (userIsInTheMiddleOfTypingANumber) {
            // [[self brain] setOperand:[[display text] doubleValue]];
            self.brain.operand = [[display text] doubleValue];
            userIsInTheMiddleOfTypingANumber = NO;
        }
    
        [self.brain performOperation:operation];
    
        display.text = [NSString stringWithFormat:@"%g", self.brain.operand];
        memoryDisplay.text = [NSString stringWithFormat:@"%g", self.brain.memoryOperand];
        alertLabel.text = self.brain.alertText;
        waitingDisplay.text = self.brain.waitingOperation;
    }
}

- (IBAction)radianSwPressed:(id)sender {
    self.brain.isRadian = [sender isOn];
    [radianSw setOn:self.brain.isRadian animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    alertLabel = nil;
    memoryDisplay = nil;
    radianSw = nil;
    waitingDisplay = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
