//
//  ViewController.m
//  Calculator
//
//  Created by MF839-014 on 2016. 6. 15..
//  Copyright © 2016년 MF839-014. All rights reserved.
//

#import "ViewController.h"
#import "Calculator.h"
#import "InfoViewController.h"
#import "ThirdViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    char op;
    int currentNumber;
    BOOL firstOperand, isNumerator, isZeroAvailable;
    Calculator *myCalculator;
    NSMutableString *displayString;
}

- (void) viewDidAppear:(BOOL)animated
{
    NSLog(@"ViewDidAppear Called");
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear Called");
}

- (void)viewDidLoad {
    NSLog(@"viewDidLoad Called");
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    firstOperand = YES;
    isNumerator = YES;
    self.zeroButton.enabled = YES;
    self.overButton.enabled = NO;
    displayString = [NSMutableString stringWithCapacity: 40];
    myCalculator = [[Calculator alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setButtonEnabled:(BOOL)val {
    for(int i = 0; i < self.opButtons.count; i++) {
        UIButton *btn = [self.opButtons objectAtIndex:i];
        btn.enabled = val;
    }
}

- (void) processDigit: (int)digit
{
    currentNumber = currentNumber * 10 + digit;
    [displayString appendString:[NSString stringWithFormat:@"%i", digit]];
    _display.text = displayString;
    self.zeroButton.enabled = YES;
    self.overButton.enabled = YES;
}

- (void) processOp: (char)theOp
{
    NSString *opStr;
    
    op = theOp;
    
    switch(theOp) {
        case '+' :
            opStr = @" + ";
            break;
        case '-' :
            opStr = @" - ";
            break;
        case '*' :
            opStr = @" X ";
            break;
        case '/' :
            opStr = @" / ";
            break;
    }
    
    [self storeFracPart];
    firstOperand = NO;
    isNumerator = YES;
    
    [displayString appendString: opStr];
    _display.text = displayString;
    
    [self setButtonEnabled:NO];
    self.overButton.enabled = NO;


}

- (void) storeFracPart
{
    if(firstOperand) {
        if(isNumerator){
            myCalculator.operand1.numerator = currentNumber;
            myCalculator.operand1.denominator = 1;
        } else {
            myCalculator.operand1.denominator = currentNumber;
        }
    }
    else if (isNumerator){
        myCalculator.operand2.numerator = currentNumber;
        myCalculator.operand2.denominator = 1;
    }
    else {
        myCalculator.operand2.denominator = currentNumber;
        firstOperand = YES;
    }
    
    currentNumber = 0;
}

- (IBAction)clickOver:(id)sender {
    [self storeFracPart];
    isNumerator = NO;
    [displayString appendString: @"/"];
    _display.text = displayString;
    self.zeroButton.enabled = NO;
}

- (IBAction)clickPlus:(id)sender {
    [self processOp: '+'];
}

- (IBAction)clickMinus:(id)sender {
    [self processOp: '-'];
}

- (IBAction)clickMultiply:(id)sender {
    [self processOp: '*'];
}

- (IBAction)clickDivide:(id)sender {
    [self processOp: '/'];
    self.zeroButton.enabled = NO;
}

- (IBAction)clickEquals:(id)sender {
    if(firstOperand == NO )
    {
        [self storeFracPart];
        [myCalculator performOperation: op];
        
        [displayString appendString: @" = "];
        [displayString appendString: [myCalculator.accumumlator convertToString]];
        _display.text = displayString;
        
        currentNumber = 0;
        isNumerator = YES;
        firstOperand = YES;
        [displayString setString: @""];

        [self setButtonEnabled:YES];
        self.zeroButton.enabled = YES;
        self.overButton.enabled = NO;

    }
}

- (IBAction)clickClear:(id)sender {
    isNumerator = YES;
    firstOperand = YES;
    currentNumber = 0;
    [myCalculator clear];
    
    [displayString setString: @""];
    _display.text = displayString;
    
    [self setButtonEnabled:YES];
    self.zeroButton.enabled = YES;
    self.overButton.enabled = NO;


}

- (IBAction)clickDigit:(UIButton *)sender {
    int digit = sender.tag;
    [self processDigit: digit];
}

- (IBAction)openInfoView:(id)sender {
    InfoViewController *infoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"infoview"];
    
    infoViewController.delegate = self;
    
    infoViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    infoViewController.myString = self.display.text;
    [self presentViewController:infoViewController animated:YES completion:nil];
}

- (IBAction)openNewAction:(UIButton*)sender {
//    [self performSegueWithIdentifier: @"blueview" sender: self];
    [self performSegueWithIdentifier: @"purpleview" sender: self];
}

-  (IBAction) unwindToViewControlle :(UIStoryboardSegue *) sender
{
    NSLog(@"unwindToViewController");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@" seg id = %@", segue.identifier);
    
    if([segue.identifier isEqualToString: @"blueview"])
    {
        InfoViewController *infoView = [segue destinationViewController];
        infoView.delegate = self;
        infoView.myString = @"HelloWorld";
    } else if([segue.identifier isEqualToString: @"purpleview"]) {
        ThirdViewController *thirdView = [segue destinationViewController];
        [thirdView changeColorFunc:^(UIColor *newColor) {
            [self.view setBackgroundColor: newColor];
        }];
        
    }
    
}
    
- (void) changeColor:(UIColor*)newColor {
    NSLog(@"Change Color");
    [self.view setBackgroundColor: newColor];
}

@end
