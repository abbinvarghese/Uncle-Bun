//
//  UBTabBarController.m
//  Uncle Bun
//
//  Created by Abbin Varghese on 02/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "UBTabBarController.h"
#import "UBSignInViewController.h"
#import "UBConstants.h"

@import Firebase;

@interface UBTabBarController ()

@end

@implementation UBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth,
                                                    FIRUser *_Nullable user) {
        if([FIRAuth auth].currentUser == nil && [[NSUserDefaults standardUserDefaults] boolForKey:firstLaunchKey]){
            UBSignInViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"UBSignInViewController"];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
