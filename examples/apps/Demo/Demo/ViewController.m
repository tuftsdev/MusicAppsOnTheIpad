//
//  ViewController.m
//  Demo
//
//  Created by Ron Lasser on 9/11/14.
//  Copyright (c) 2014 org.rl. All rights reserved.
//

#import "ViewController.h"
#import "GraphViewController.h"
#import "TheData.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *displayLabel;
@property (strong, nonatomic) NSTimer * myTimer;
@property (strong, nonatomic) NSTimer * patienceTimer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// add after demo the problems with the interface, do view did load first, then sovle the problem
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.displayLabel.text = @"5"; // sets timer length
    self.displayLabel.backgroundColor = [UIColor blackColor];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //self.displayLabel.text = @"5";  // can just see it changing
    
    UIImage * dragonImage = [UIImage imageNamed:@"dragon.png"];
    self.dragonImageView.image = dragonImage;
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
}
- (IBAction)buttonPress:(UIButton *)sender {  // via control - drag from storyboard
    
    if (self.eeyoreView.hidden == FALSE) {
        self.eeyoreView.hidden = TRUE;
    }
    else
        self.eeyoreView.hidden = FALSE;
    
}

- (void) countDown: (NSTimer *) timer
{
    NSNumber *count = [NSNumber numberWithInteger: [self.displayLabel.text integerValue]];
    NSUInteger countNSInt = [count integerValue];
    --countNSInt;
    count = [NSNumber numberWithInteger:countNSInt];
    self.displayLabel.text = [NSString stringWithFormat:@"%@", count];
    if (![count integerValue]) {
       // NSLog(@"test: %ld", (long)[count integerValue]);
        [timer invalidate];
        self.patienceTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(patience:) userInfo:nil repeats:YES];
        [self patience: self.patienceTimer];
        [self performSegueWithIdentifier:@"ToGraph" sender:self];
    }
}

- (void) patience: (NSTimer *) timer
{
    self.displayLabel.backgroundColor = [UIColor redColor];
    [timer invalidate];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ToGraph"])
    {
        GraphViewController * graphVC = [segue destinationViewController];
        graphVC.doNotShowGraph = self.eeyoreView.hidden;
        graphVC.controllerLabelText = @"Arrrived @ graphVC";
        
    }
}

- (IBAction)returnedFromGraphVC: (UIStoryboardSegue *) segue
{
    NSLog(@"Returned from graphVC");
}

- (void) printData
{
    TheData * theData = [[TheData alloc] init];

    NSLog(@"%@", [theData description]);

    for (NSInteger i = 0; i < [[theData getDataX] count]; ++i) {
        float x = [[[theData getDataX] objectAtIndex:i] floatValue];
        float y = [[[theData getDataY] objectAtIndex:i] floatValue];
        NSLog(@" %ld: %3.2f, %3.2f", (long) i,x, y);
    }
}

@end
