//
//  UBSignInViewController.m
//  Uncle Bun
//
//  Created by Abbin Varghese on 02/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "UBSignInViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface UBSignInViewController ()<FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *facebookLoginButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelConstrain;
@property (weak, nonatomic) IBOutlet UILabel *HeaderLabel;

@end

@implementation UBSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _facebookLoginButton.delegate = self;
    _facebookLoginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];

    NSString *fontTwo = @"";
    if ([UIFont fontWithName:@".SFUIDisplay-Thin" size:10]) {
        fontTwo = @".SFUIDisplay-Light";
    }
    else{
        fontTwo = @".HelveticaNeueInterface-Thin";
    }
    
    NSString *string = @"WELCOME";
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:string];

    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:fontTwo size:[UIScreen mainScreen].bounds.size.width/14]
                  range:NSMakeRange(0, string.length)];
    
    _HeaderLabel.attributedText = hogan;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self animateLabel];
}

-(void)animateLabel{
    [UIView animateWithDuration:0.5 delay:5.0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        _labelConstrain.constant = 50;
        _HeaderLabel.alpha = 0;
        [self.viewIfLoaded layoutIfNeeded];
    } completion:^(BOOL finished) {
        NSString *fontname = @"";
        NSString *fontTwo = @"";
        if ([UIFont fontWithName:@".SFUIDisplay-Thin" size:10]) {
            fontname = @".SFUIDisplay-Thin";
            fontTwo = @".SFUIDisplay-Light";
        }
        else{
            fontTwo = @".HelveticaNeueInterface-Thin";
            fontname = @".HelveticaNeueInterface-UltraLightP2";
        }
        
        NSString *string = @"Every DISH is great!\nWe sort them for you by\nLocation.";
        NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:string];
        [hogan addAttribute:NSFontAttributeName
                      value:[UIFont fontWithName:fontname size:[UIScreen mainScreen].bounds.size.width/16]
                      range:NSMakeRange(0, string.length)];
        [hogan addAttribute:NSFontAttributeName
                      value:[UIFont fontWithName:fontTwo size:[UIScreen mainScreen].bounds.size.width/14]
                      range:NSMakeRange(6, 5)];
        [hogan addAttribute:NSFontAttributeName
                      value:[UIFont fontWithName:fontTwo size:[UIScreen mainScreen].bounds.size.width/14]
                      range:NSMakeRange(45, 8)];
        
        _HeaderLabel.attributedText = hogan;

        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _labelConstrain.constant = 0;
            _HeaderLabel.alpha = 1;
            [self.viewIfLoaded layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:5.0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                _labelConstrain.constant = 50;
                _HeaderLabel.alpha = 0;
                [self.viewIfLoaded layoutIfNeeded];
            } completion:^(BOOL finished) {
                
                NSString *fontname = @"";
                NSString *fontTwo = @"";
                if ([UIFont fontWithName:@".SFUIDisplay-Thin" size:10]) {
                    fontname = @".SFUIDisplay-Thin";
                    fontTwo = @".SFUIDisplay-Light";
                }
                else{
                    fontTwo = @".HelveticaNeueInterface-Thin";
                    fontname = @".HelveticaNeueInterface-UltraLightP2";
                }
                
                NSString *string = @"Found something new?\nDont eat alone.\nLet the others know.\nFOOD is always best shared";
                NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:string];
                [hogan addAttribute:NSFontAttributeName
                              value:[UIFont fontWithName:fontname size:[UIScreen mainScreen].bounds.size.width/16]
                              range:NSMakeRange(0, string.length)];
                [hogan addAttribute:NSFontAttributeName
                              value:[UIFont fontWithName:fontTwo size:[UIScreen mainScreen].bounds.size.width/14]
                              range:NSMakeRange(16, 3)];
                [hogan addAttribute:NSFontAttributeName
                              value:[UIFont fontWithName:fontTwo size:[UIScreen mainScreen].bounds.size.width/14]
                              range:NSMakeRange(58, 4)];
                
                _HeaderLabel.attributedText = hogan;
                
                [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    _labelConstrain.constant = 0;
                    _HeaderLabel.alpha = 1;
                    [self.viewIfLoaded layoutIfNeeded];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.5 delay:5.0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                        _labelConstrain.constant = 50;
                        _HeaderLabel.alpha = 0;
                        [self.viewIfLoaded layoutIfNeeded];
                    } completion:^(BOOL finished) {
                        NSString *fontname = @"";
                        NSString *fontTwo = @"";
                        if ([UIFont fontWithName:@".SFUIDisplay-Thin" size:10]) {
                            fontname = @".SFUIDisplay-Thin";
                            fontTwo = @".SFUIDisplay-Light";
                        }
                        else{
                            fontTwo = @".HelveticaNeueInterface-Thin";
                            fontname = @".HelveticaNeueInterface-UltraLightP2";
                        }
                        
                        NSString *string = @"Join our NETWORK.\nDiscover a world of TASTE";
                        NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:string];
                        [hogan addAttribute:NSFontAttributeName
                                      value:[UIFont fontWithName:fontname size:[UIScreen mainScreen].bounds.size.width/16]
                                      range:NSMakeRange(0, string.length)];
                        [hogan addAttribute:NSFontAttributeName
                                      value:[UIFont fontWithName:fontTwo size:[UIScreen mainScreen].bounds.size.width/14]
                                      range:NSMakeRange(9, 8)];
                        [hogan addAttribute:NSFontAttributeName
                                      value:[UIFont fontWithName:fontTwo size:[UIScreen mainScreen].bounds.size.width/14]
                                      range:NSMakeRange(38, 5)];
                        
                        _HeaderLabel.attributedText = hogan;

                        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            _labelConstrain.constant = 0;
                            _HeaderLabel.alpha = 1;
                            [self.viewIfLoaded layoutIfNeeded];
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }];
        }];
    }];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    
}

@end
