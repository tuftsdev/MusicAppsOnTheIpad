//
//  ViewController.m
//  TweetsTable
//
//  Created by Ming Chow on 3/13/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize tweetsTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add our table subview
    self.view.backgroundColor = [UIColor whiteColor];
    self.tweetsTable = [[UITableView alloc]initWithFrame:self.view.bounds 
                                                   style:UITableViewStylePlain];
    
    [self.view addSubview:self.tweetsTable];
    
    // Set up data source for table
    self.tweetsTable.dataSource = self;

    // Ensure that the table autoresizes correctly
    self.tweetsTable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Initialize tweets array
    tweets = [[NSMutableArray alloc] init];
    
    // Get my tweets; set up URL
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1/statuses/user_timeline/tufts_cs_mchow.json"];
    
    // Set up a concurrent queue
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSData* data = [NSData dataWithContentsOfURL:url];
        [self performSelectorOnMainThread:@selector(parseData:)
                               withObject:data
                            waitUntilDone:YES];
    });
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Required for UITableViewDataSource protocol: informs table view of the number of sections to be loaded onto table
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Required for UITableViewDataSource protocol: informs table view of how many rows to be loaded in each section
    return [tweets count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Required for UITableViewDataSource protocol: Responsible for returning instances of the UITableViewCell class
    
    static NSString *cellIdentifier = @"Tweet";
    UITableViewCell *cell = nil;
    if ([tableView isEqual:self.tweetsTable]) {

        // Set up cell
        cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:cellIdentifier];
        }
        
        // Set the text of the cell
        cell.textLabel.text = [tweets objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)parseData:(NSData *)responseData
{
    NSError* error;
    
    // NEW in iOS 5: NSJSONSerialization
    // No more third-party libraries necessary for JSON parsing
    NSArray *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                    options:0
                                                      error:&error];
    
    // Iterate through tweets
    NSEnumerator *it = [json objectEnumerator];
    NSDictionary *tweet;
    while (tweet = [it nextObject]) {
        [tweets addObject:[tweet objectForKey:@"text"]];
    }
    
    // IMPORTANT! Reload the table data
    [self.tweetsTable reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
