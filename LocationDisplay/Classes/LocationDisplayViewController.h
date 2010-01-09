//
//  LocationDisplayViewController.h
//  LocationDisplay
//
//  Created by Jason Bell on 01/10/2009.
//  Copyright Datasentiment 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationDisplayViewController : UIViewController <CLLocationManagerDelegate>{
	CLLocationManager *locationManager;
	IBOutlet UITextField *latitudeTextField;
	IBOutlet UITextField *longitudeTextField;
	IBOutlet UITextField *routeName;
	IBOutlet UIButton *storeLocationButton;
	IBOutlet UIButton *getLocationButton;
	IBOutlet UIButton *uploadDataButton;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) IBOutlet UITextField *latitudeTextField;
@property (nonatomic, retain) IBOutlet UITextField *longitudeTextField;
@property (nonatomic, retain) IBOutlet UITextField *routeName;
@property (nonatomic, retain) IBOutlet UIButton *storeLocationButton;
@property (nonatomic, retain) IBOutlet UIButton *getLocationButton;
@property (nonatomic, retain) IBOutlet UIButton *uploadDataButton;


- (IBAction)getLocation:(id)sender;
- (IBAction)storeLocation:(id)sender;
- (IBAction)uploadData:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;

@end

