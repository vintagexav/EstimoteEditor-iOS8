//
//  EEAppDelegate.m
//  Estimote Editor
//
//  Created by Yoann Gini on 13/11/2013.
//  Copyright (c) 2013 Yoann Gini. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "EEAppDelegate.h"
#import "EETableViewController.h"

@interface EEAppDelegate ()

@property  CLLocationManager *locationManager;

@end

@implementation EEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[EETableViewController alloc] initWithStyle:UITableViewStylePlain]];
	[(UINavigationController*)self.window.rootViewController navigationBar].translucent = NO;
	
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self alertLocationServices];
    return YES;
}


//To make it iOS8 compatible.
//It needs Always Auth in order to do monitoring
- (void) alertLocationServices{
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    if ([CLLocationManager locationServicesEnabled]) { //Just ask for ALWAYS (not in use) if you want to monitor zones, do significatn changes meausrement AND appear on homescreen
        
        // This is the right way to ask for Location rights in iOS7.
        //(see https://developer.apple.com/library/mac/documentation/CoreLocation/Reference/CLLocationManager_Class/CLLocationManager/CLLocationManager.html#//apple_ref/occ/clm/CLLocationManager/locationServicesEnabled)
        
        //        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {//it has to be self.locationManager, else the popup gets dismissed after those lines
        //            //then we are currently running on iOS8
        //
        //            [self.locationManager performSelector:@selector(requestWhenInUseAuthorization)]; //or [self.locationManager requestAlwaysAuthorization]; but this works only on iOS8 BASE SDK
        //            //This is the right way to ask for location rights in iOS 8 when using the new inUse Flags
        //        }
        //
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {//it has to be self.locationManager, else the popup gets dismissed after those lines
            //then we are currently running on iOS8
            
            [self.locationManager performSelector:@selector(requestAlwaysAuthorization)]; //or [self.locationManager requestWhenInUseAuthorization]; but this works only on iOS8 BASE SDK
            //This is the right way to ask for location rights in iOS 8 when using the new inUse Flags
         
        }
        //Only here start monitoring location updates
    }
}


@end
