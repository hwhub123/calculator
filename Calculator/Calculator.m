//
//  Calculator.m
//  objc
//
//  Created by MF839-014 on 2016. 6. 14..
//  Copyright © 2016년 MF839-014. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

- (id) init
{
    self = [super init];
    
    if(self)
    {
        _operand1 = [[Fraction alloc] init];
        _operand2 = [[Fraction alloc] init];
        _accumumlator = [[Fraction alloc] init];
    }
    return self;
}


- (void)clear {
    _accumumlator.numerator = 0;
    _accumumlator.denominator = 0;
}

- (Fraction *) performOperation:(char)op
{
    Fraction *result;
    
    switch(op)
    {
        case '+':
            result = [_operand1 add: _operand2];
            break;
        case '-':
            result = [_operand1 sub: _operand2];
            break;
        case '*':
            result = [_operand1 mul: _operand2];
            break;
        case '/':
            result = [_operand1 div: _operand2];
            break;
    }
    
    _accumumlator.numerator = result.numerator;
    _accumumlator.denominator = result.denominator;
    
    return _accumumlator;
}

@end
