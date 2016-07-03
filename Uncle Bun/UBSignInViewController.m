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
#import <AVFoundation/AVFoundation.h>

@interface UBSignInViewController ()<FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *facebookLoginButton;
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (nonatomic, strong) AVPlayer *avplayer;
@property (weak, nonatomic) IBOutlet UIImageView *logo;

@end

@implementation UBSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVideoBackground];
    
    _facebookLoginButton.delegate = self;
    _facebookLoginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%f",_logo.frame.size.height);
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.avplayer pause];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.avplayer play];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    
}

- (void)initVideoBackground{
    
    NSError *sessionError = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&sessionError];
    [[AVAudioSession sharedInstance] setActive:YES error:&sessionError];
    
    //Set up player
    NSURL *movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMG_0101" ofType:@"mp4"]];
    AVAsset *avAsset = [AVAsset assetWithURL:movieURL];
    AVPlayerItem *avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
    self.avplayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
    AVPlayerLayer *avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:self.avplayer];
    [avPlayerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [avPlayerLayer setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*9/14)];
    [self.playerView.layer addSublayer:avPlayerLayer];
    //Config player
    [self.avplayer seekToTime:kCMTimeZero];
    [self.avplayer setVolume:0.0f];
    [self.avplayer setActionAtItemEnd:AVPlayerActionAtItemEndNone];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.avplayer currentItem]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerStartPlaying)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
}

- (void)playerStartPlaying{
    
    [self.avplayer play];
    
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
    
}


@end
