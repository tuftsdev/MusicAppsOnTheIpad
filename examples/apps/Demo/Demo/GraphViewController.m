//
//  GraphViewController.m
//  Demo
//
//  Created by Ron Lasser on 9/12/14.
//  Copyright (c) 2014 org.rl. All rights reserved.
//

#import "GraphViewController.h"
#import "Graph.h"
#import "PlotSymbol.h"
#import "TheData.h"

@interface GraphViewController ()
@property (strong, nonatomic) IBOutlet Graph *graph;
//@property (strong, nonatomic) PlotSymbol *symbol;

// model
@property (nonatomic, strong) TheData *graphData;

@end

@implementation GraphViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
- (PlotSymbol *) symbol
{
    if (!_symbol){
        _symbol = [[PlotSymbol alloc] initWithFrame:CGRectZero];
    }
    
    return _symbol;
}
*/

- (TheData *) graphData
{
    if (!_graphData){
        _graphData = [[TheData alloc] init];
    }
    return _graphData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.controllerLabel.text = self.controllerLabelText;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.graph.hidden = YES;
    //NSArray * myArray = @[@0, @1,  @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12];
    //[self.graph.graphXData addObjectsFromArray:myArray];
    //[self.graph printArray];
    [self.graph.graphXData addObjectsFromArray:[self.graphData getDataX]];
    [self.graph.graphYData addObjectsFromArray:[self.graphData getDataY]];

}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.doNotShowGraph) {
        NSLog(@"Do not show graph");
    }
    else {
        NSLog(@"Show graph");
        self.graph.hidden = NO;

    }
/*
    //[self.graph setNeedsDisplay];
    CGPoint ap = CGPointMake(125, 150);
    CGSize as = CGSizeMake(10, 10);
    [self.symbol setLocation:ap];
    [self.symbol setSize:as];
    
    //CGPoint p = CGPointMake(self.symbol.location.x,self.symbol.location.y);
    //CGSize s = self.symbol.size;
   // NSLog(@"*** %3.2f, %3.2f %3.2f, %3.2f", p.x, p.y, s.width, s.height);
    
    self.symbol = [[PlotSymbol alloc]initWithFrame:CGRectMake(ap.x, ap.y, as.width, as.height)];
     CGRect cgr = self.symbol.frame;
     NSLog(@"*** %3.2f, %3.2f %3.2f, %3.2f", cgr.origin.x, cgr.origin.y, cgr.size.width, cgr.size.height);
*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
