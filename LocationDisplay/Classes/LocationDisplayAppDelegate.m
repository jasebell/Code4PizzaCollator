//
//  LocationDisplayAppDelegate.m
//  LocationDisplay
//
//  Created by Jason Bell on 01/10/2009.
//  Copyright Datasentiment 2009. All rights reserved.
//

#import "LocationDisplayAppDelegate.h"
#import "LocationDisplayViewController.h"

@implementation LocationDisplayAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize dbFilePath;


NSString *DATABASE_RESOURCE_NAME = @"code4pizzacollator";
NSString *DATABASE_RESOURCE_TYPE = @"db";
NSString *DATABASE_FILE_NAME = @"code4pizzacollator.db";

- (BOOL) initializeDb {
	NSLog (@"initializeDB");
	NSArray *searchPaths =
	NSSearchPathForDirectoriesInDomains
	(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentFolderPath = [searchPaths objectAtIndex: 0];
	dbFilePath = [documentFolderPath stringByAppendingPathComponent:
				  DATABASE_FILE_NAME];

	[dbFilePath retain];

	if (! [[NSFileManager defaultManager] fileExistsAtPath: dbFilePath]) {

		NSString *backupDbPath = [[NSBundle mainBundle]
								  pathForResource:DATABASE_RESOURCE_NAME
								  ofType:DATABASE_RESOURCE_TYPE];
		if (backupDbPath == nil) {
			NSLog(@"Can't find DB path.");
			return NO;
		} else {
			BOOL copiedBackupDb = [[NSFileManager defaultManager]
								   copyItemAtPath:backupDbPath
								   toPath:dbFilePath
								   error:nil];
			if (! copiedBackupDb) {
				NSLog(@"Didn't do the backup.");
				return NO;
			}
		}
	}
	return YES;
	NSLog (@"bottom of initializeDb");
}


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	if (! [self initializeDb]) {
		// TODO: alert the user!
		NSLog (@"couldn't init db");
		return;
	}	
	   
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
