//
//  InfoViewController.h
//  Calculator
//
//  Created by MF839-014 on 2016. 6. 16..
//  Copyright © 2016년 MF839-014. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InfoViewProtocol <NSObject>
- (void) changeColor:(UIColor*) newColor;
@end

@interface InfoViewController : UIViewController

@property (nonatomic, strong) NSString* myString;

@property (strong, nonatomic) IBOutlet UILabel *myLable;

@property (nonatomic, strong) id<InfoViewProtocol> delegate;

- (IBAction)changeColor:(id)sender;


@end
