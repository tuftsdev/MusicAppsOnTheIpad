//
//  ViewController.h
//  TipCalculator
//
//  Created by Ming Chow on 1/11/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, retain) IBOutlet UITextField *billDollarAmount;
@property (nonatomic, retain) IBOutlet UITextField *billCentsAmount;
@property (nonatomic, retain) IBOutlet UIPickerView *percentage;
@property (nonatomic, retain) IBOutlet UILabel *tipAmount;
@property (nonatomic, strong) NSMutableArray *percentages;

-(IBAction)calculate:(id)sender;
-(IBAction)backgroundTouched:(id)sender;

@end
