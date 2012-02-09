//
//  ControlsFunViewController.h
//  ControlsFun
//
//  Created by Ming Chow on 12/28/09.
//  Copyright Tufts University 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ControlsFunViewController : UIViewController<UIAlertViewDelegate, CLLocationManagerDelegate>
{
	IBOutlet UILabel *angleSliderLabel;
	IBOutlet UILabel *velocitySliderLabel;
	IBOutlet UILabel *statusLabel;
@private
    float myLat, myLng;
}

@property (nonatomic, retain) UILabel *angleSliderLabel, *velocitySliderLabel, *statusLabel;
@property (nonatomic, retain) CLLocationManager *myLocationManager;

-(IBAction) angleSliderChanged: (id)sender;
-(IBAction) velocitySliderChanged: (id)sender;
-(IBAction) buttonPressed: (id)sender;

@end
