//
//  UBFirstLocationViewController.m
//  Uncle Bun
//
//  Created by Abbin Varghese on 06/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "UBFirstLocationViewController.h"
#import "UBLocationViewController.h"
#import "UBConstants.h"
#import "NSMutableDictionary+TFALocation.h"
#import "AppDelegate.h"

@interface UBFirstLocationViewController ()<UBLocationDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation UBFirstLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)detectLocation:(UIButton *)sender {
    [_activityIndicator startAnimating];
    [[GMSPlacesClient sharedClient] currentPlaceWithCallback:^(GMSPlaceLikelihoodList * _Nullable likelihoodList, NSError * _Nullable error) {
        if (error == nil) {
            GMSPlaceLikelihood *likelihood = [likelihoodList.likelihoods objectAtIndex:0];
            GMSPlace* place = likelihood.place;
            NSMutableDictionary *obj = [[NSMutableDictionary alloc]initWithGMSPlace:place];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:obj forKey:userLocationKey];
            [defaults setBool:YES forKey:firstLaunchKey];
            [defaults synchronize];
            [_activityIndicator stopAnimating];
            
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate switchToTabBar];
        }
        else{
            [_activityIndicator stopAnimating];
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to get your current location" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }];
}

- (IBAction)selectMannually:(UIButton *)sender {
    UBLocationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"UBLocationViewController"];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)UBLocation:(UBLocationViewController *)controller didFinishGettingLocation:(NSMutableDictionary *)location{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:location forKey:userLocationKey];
    [defaults setBool:YES forKey:firstLaunchKey];
    [defaults synchronize];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate switchToTabBar];
}

@end
