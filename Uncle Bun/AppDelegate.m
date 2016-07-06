//
//  AppDelegate.m
//  Uncle Bun
//
//  Created by Abbin Varghese on 02/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "AppDelegate.h"
#import "UBColor.h"
#import "UBConstants.h"
#import "UBSignInViewController.h"
#import "UBTabBarController.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UBFirstLocationViewController.h"

@import Firebase;
@import GoogleMaps;

@interface AppDelegate ()

@property (nonatomic, strong) FIRRemoteConfig *remoteConfig;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UITabBar appearance] setTintColor:[UBColor UBRed]];
    [FIRApp configure];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    [FBSDKLoginButton class];
    
    self.remoteConfig = [FIRRemoteConfig remoteConfig];
    FIRRemoteConfigSettings *remoteConfigSettings = [[FIRRemoteConfigSettings alloc] initWithDeveloperModeEnabled:YES];
    self.remoteConfig.configSettings = remoteConfigSettings;
    [self.remoteConfig setDefaultsFromPlistFileName:@"RemoteConfigDefaults"];
    
    [self.remoteConfig fetchWithCompletionHandler:^(FIRRemoteConfigFetchStatus status, NSError * _Nullable error) {
        if (status == FIRRemoteConfigFetchStatusSuccess) {
            [self.remoteConfig activateFetched];
        }
    }];
    
    [GMSServices provideAPIKey:@"AIzaSyAk4Xjl2nA8CDEuFvWCpq74gPu8fYTR4YQ"];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:firstLaunchKey]) {
        if ([FIRAuth auth].currentUser == nil) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UBSignInViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"UBSignInViewController"];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:rootViewController];
            nav.navigationBarHidden = YES;
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        }
        else{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UBFirstLocationViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"UBFirstLocationViewController"];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:rootViewController];
            nav.navigationBarHidden = YES;
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        }
    }
    
//    NSError *error;
//    [[FIRAuth auth] signOut:&error];
//    if (!error) {
//        // Sign-out succeeded
//    }
    
    return YES;
}

-(void)switchToTabBar{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UBTabBarController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"UBTabBarController"];
    self.window.rootViewController = rootViewController;
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
    
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

@end
