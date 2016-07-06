//
//  FirstViewController.m
//  Uncle Bun
//
//  Created by Abbin Varghese on 02/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "FirstViewController.h"
#import "UBLocationViewController.h"
#import "UBConstants.h"

@import Firebase;

@interface FirstViewController ()<UBLocationDelegate>

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *locDict = [[NSUserDefaults standardUserDefaults] objectForKey:userLocationKey];
    _locationLabel.text = [locDict objectForKey:locationNameKey];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getLocation:(id)sender {
    UBLocationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"UBLocationViewController"];
    vc.providesPresentationContextTransitionStyle = YES;
    vc.definesPresentationContext = YES;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)UBLocation:(UBLocationViewController *)controller didFinishGettingLocation:(NSMutableDictionary *)location{
    _locationLabel.text = location[locationNameKey];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:location forKey:userLocationKey];
    [defaults synchronize];
}

@end
