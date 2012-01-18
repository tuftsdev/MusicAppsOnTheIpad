//
//  ControlsFunViewController.m
//  ControlsFun
//
//  Created by Ming Chow on 12/28/09.
//  Copyright Tufts University 2009. All rights reserved.
//

#import "ControlsFunViewController.h"

@implementation ControlsFunViewController

@synthesize angleSliderLabel, velocitySliderLabel, statusLabel, myLocationManager;

-(IBAction)angleSliderChanged: (id)sender;
{
	UISlider *slider = (UISlider *)sender;
	int angleAsInt = (int)(slider.value);
	NSString *newText = [[NSString alloc] initWithFormat:@"%i deg", angleAsInt];
	angleSliderLabel.text = newText;
	[newText release];
}

-(IBAction)velocitySliderChanged: (id)sender;
{
	UISlider *slider = (UISlider *)sender;
	int velocityAsInt = (int)(slider.value);
	NSString *newText = [[NSString alloc] initWithFormat:@"%i m/s", velocityAsInt];
	velocitySliderLabel.text = newText;
	[newText release];
}

-(IBAction) buttonPressed: (id)sender
{
	NSString *title = [sender titleForState:UIControlStateNormal];
	NSString *newText = [[NSString alloc] initWithFormat: @"%@", title];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fired!" message:@"Coming Soon..." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
	if ([newText isEqualToString:@"Fire!"]) {
		[alert show];
	}
    else if ([newText isEqualToString:@"Get Location"]) {
        if ([CLLocationManager locationServicesEnabled]) {
            NSString *result = [NSString stringWithFormat:@"Your lat,lng is %f,%f", myLat, myLng];
            [statusLabel setText:result];
        }
        else {
            [statusLabel setText:@"Location services not enabled."];
        }
    }
    [alert release];
	[newText release];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    myLat = newLocation.coordinate.latitude;
    myLng = newLocation.coordinate.longitude;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [statusLabel setText:@"Sorry, your location could not be retrieved!"];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    NSLog(@"You clicked on the button \"%@\"", buttonTitle);
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    myLocationManager = [[CLLocationManager alloc] init];
    [myLocationManager setDelegate:self];
    [myLocationManager setPurpose:@"Identifing where I am"];
    [myLocationManager startUpdatingLocation];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
