//
//  AppDelegate.m
//  Flicks
//
//  Created by Yemane Tekleab on 1/24/17.
//  Copyright © 2017 Yemane Tekleab. All rights reserved.
//

#import "AppDelegate.h"
#import "MoviesViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    // Set up the first View Controller
    MoviesViewController *vc1 =[storyboard instantiateViewControllerWithIdentifier:@"MovieViewController"];
    vc1.viewType = @"now_playing";
    vc1.tabBarItem.title = @"Now Playing";
    vc1.tabBarItem.image = [UIImage imageNamed:@"iconmonstr-video-9.png"];
    
    
    UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    // Set up the second View Controller
    MoviesViewController *vc2 = [storyboard instantiateViewControllerWithIdentifier:@"MovieViewController"];
    vc2.viewType = @"top_rated";
    vc2.tabBarItem.title = @"Top Rated";
    vc2.tabBarItem.image = [UIImage imageNamed:@"iconmonstr-star-2.png"];
    
    UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    // Set up the Tab Bar Controller to have two tabs
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:@[nc1, nc2]];
    
    // Make the Tab Bar Controller the root view controller
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
