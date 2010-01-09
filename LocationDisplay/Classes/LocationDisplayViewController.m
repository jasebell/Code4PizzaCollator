//
//  LocationDisplayViewController.m
//  LocationDisplay
//
//  Created by Jason Bell on 01/10/2009.
//  Copyright Datasentiment 2009. All rights reserved.
//

#import "LocationDisplayViewController.h"
#import "LocationDisplayAppDelegate.h"
#include <sqlite3.h>

@implementation LocationDisplayViewController

@synthesize locationManager;
@synthesize latitudeTextField;
@synthesize longitudeTextField;
@synthesize routeName;
@synthesize storeLocationButton;
@synthesize getLocationButton;
@synthesize uploadDataButton;

-(void)viewDidLoad {
	[super viewDidLoad];
}

- (IBAction)getLocation:(id)sender {
	self.locationManager = [[[CLLocationManager alloc] init] autorelease]; 
	self.locationManager.delegate = self; 
	[self.locationManager startUpdatingLocation]; 	
}

- (IBAction)storeLocation:(id)sender {
	NSLog(routeName.text);
	NSLog(latitudeTextField.text);
	NSLog(longitudeTextField.text);
	
	if (([routeName.text length] == 0) ||
		([latitudeTextField.text length] == 0) ||
		([longitudeTextField.text length] == 0))
		return;
	
	sqlite3 *db;
	int dbrc; // database return code
	LocationDisplayAppDelegate *appDelegate = (LocationDisplayAppDelegate*)[UIApplication sharedApplication].delegate;
	const char* dbFilePathUTF8 = [appDelegate.dbFilePath UTF8String];
	dbrc = sqlite3_open (dbFilePathUTF8, &db);
	if (dbrc) {
		return;
	}
	
	sqlite3_stmt *dbps; 	
	NSString *insertStatementNS = [NSString stringWithFormat:
								   @"insert into \"storedstops\" (created_at, route, lat, lon, uploaded) values (DATETIME('NOW'), \"%@\", \"%@\", \"%@\", 0);",
								   routeName.text,
								   latitudeTextField.text, 
								   longitudeTextField.text ];
	NSLog(insertStatementNS);
	const char *insertStatement = [insertStatementNS UTF8String];
	dbrc = sqlite3_prepare_v2 (db, insertStatement, -1, &dbps, NULL);
	dbrc = sqlite3_step (dbps);
	dbrc = sqlite3_finalize (dbps);
	dbrc = sqlite3_close(db);
	
	// show an alert to say it was added to the database.
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bus Stop Data Stored" message:[NSString stringWithFormat:@"%@, %@ added for route %@", 
																							 latitudeTextField.text, longitudeTextField.text,routeName.text ] delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
	
	// reset the values for the lat/lon
	latitudeTextField.text = @"";
	longitudeTextField.text = @"";
}
// TODO: Select data from database and send it across to the server.
// Not sure whether to do JSON data out yet.
- (IBAction)uploadData:(id)sender {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Data" message:@"This action is currently unsupported." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (IBAction)textFieldDoneEditing:(id)sender {
	[sender resignFirstResponder];
}

- (void)locationManager:(CLLocationManager *)manager 
	didUpdateToLocation:(CLLocation *)newLocation 
		   fromLocation:(CLLocation *)oldLocation { 
	latitudeTextField.text = [NSString stringWithFormat:@"%3.7f", 
							  newLocation.coordinate.latitude]; 
	longitudeTextField.text = [NSString stringWithFormat:@"%3.7f", 
							   newLocation.coordinate.longitude]; 
	
	
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


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


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
