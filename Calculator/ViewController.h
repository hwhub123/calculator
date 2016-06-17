//
//  ViewController.h
//  Calculator
//
//  Created by MF839-014 on 2016. 6. 15..
//  Copyright © 2016년 MF839-014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"

@interface ViewController : UIViewController <InfoViewProtocol>

@property (weak, nonatomic) IBOutlet UILabel *display;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *opButtons;

@property (weak, nonatomic) IBOutlet UIButton *zeroButton;
@property (weak, nonatomic) IBOutlet UIButton *overButton;

- (void) processDigit: (int)digit;
- (void) processOp: (char)theOp;
- (void) storeFracPart;

- (IBAction)clickPlus:(id)sender;
- (IBAction)clickMinus:(id)sender;
- (IBAction)clickMultiply:(id)sender;
- (IBAction)clickDivide:(id)sender;

- (IBAction)clickEquals:(id)sender;
- (IBAction)clickOver:(id)sender;
- (IBAction)clickClear:(id)sender;

- (IBAction)clickDigit:(id)sender;

-  (IBAction) unwindToViewControlle :(UIStoryboardSegue *) sender;


- (IBAction)openInfoView:(id)sender;

- (IBAction)openNewAction:(UIButton *)sender;

- (void) changeColor:(UIColor*)newColor;

@end

