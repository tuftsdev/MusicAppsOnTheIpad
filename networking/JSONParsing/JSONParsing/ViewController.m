//
//  ViewController.m
//  JSONParsing
//
//  Created by Ming Chow on 3/8/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set up URL
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
        NSLog(@"TWEET: %@", [tweet objectForKey:@"text"]);
    }
}


- (void)viewDidUnload
{
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
    return YES;
}

@end
