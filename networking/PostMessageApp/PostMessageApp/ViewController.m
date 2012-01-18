//
//  ViewController.m
//  LecturerApp
//
//  Created by Ming Chow on 1/10/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize content, feedback;

// Touch down event = button tap
// Touch up inside = button press

-(IBAction)buttonPressed:(id)sender
{
    NSString *text = [content text];
    [feedback setText:@""];
    if ([text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problem"
                                                        message:@"Um, you didn't type in anything!"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil,                              nil];
        [alert show];
    }
    else {
        NSString *urlAsString = @"http://lecturer.heroku.com/posts";
        urlAsString = [urlAsString stringByAppendingString:@"?post[username]=mchow"];
        urlAsString = [urlAsString stringByAppendingFormat:@"&post[content]=%@",text];
        urlAsString = [urlAsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; // Url encoding
        NSURL *url = [NSURL URLWithString:urlAsString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setTimeoutInterval:30.0f];
        [request setHTTPMethod:@"POST"];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:queue
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error == nil) {
                                       [feedback setText:@"Content successfully sent!"];
                                   }
                                   else {
                                       [feedback setText:@"Whoops, something went wrong! Content was not sent"];
                                       //NSLog(@"***** Error: %@", error);
                                   }
                               }];
    }
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
