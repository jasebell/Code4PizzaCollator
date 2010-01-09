//
//  LocationDisplayAppDelegate.h
//  LocationDisplay
//
//  Created by Jason Bell on 01/10/2009.
//  Copyright Datasentiment 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationDisplayViewController;

@interface LocationDisplayAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    LocationDisplayViewController *viewController;
	NSString *dbFilePath;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet LocationDisplayViewController *viewController;
@property (nonatomic, retain, readonly) NSString *dbFilePath;

@end

