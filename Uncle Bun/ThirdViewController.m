//
//  ThirdViewController.m
//  Uncle Bun
//
//  Created by Abbin Varghese on 02/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "ThirdViewController.h"
#import "UBColor.h"
#import "UBSignInViewController.h"
#import "UBConstants.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <MessageUI/MessageUI.h>

#define YOUR_APP_STORE_ID 284882215 //Change this one to your ID
static NSString *const iOS7AppStoreURLFormat = @"itms-apps://itunes.apple.com/app/id%d";

@import Firebase;

@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *accountTableView;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *photoUrl;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth,
                                                    FIRUser *_Nullable user) {
        if (user != nil && !user.isAnonymous){
            for (id<FIRUserInfo> profile in user.providerData) {
                _name = profile.displayName;
                _photoUrl = profile.photoURL;
            }
        }
        [_accountTableView reloadData];
    }];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([FIRAuth auth].currentUser.isAnonymous) {
        return 4;
    }
    else{
        return 5;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 3;
            break;
        case 4:
            return 1;
            break;
            
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            if ([FIRAuth auth].currentUser.isAnonymous) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
                cell.textLabel.text = @"Connect with an account";
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.detailTextLabel.text = @"";
                cell.imageView.image = [UIImage imageNamed:@"Profile Placeholder"];
                return cell;
            }
            else{
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
                cell.textLabel.text = _name;
                cell.textLabel.font = [UIFont systemFontOfSize:20];
                cell.detailTextLabel.text = @"Facebook";
                [cell.imageView sd_setImageWithURL:_photoUrl placeholderImage:[UIImage imageNamed:@"Profile Placeholder"]];
                return cell;
            }
        }
            break;
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
                    cell.textLabel.text = @"Rate us on the AppStore";
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.detailTextLabel.text = @"";
                    cell.imageView.image = [UIImage imageNamed:@"Appstore"];
                    return cell;
                }
                    break;
                case 1:{
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
                    cell.textLabel.text = @"Send us a feedback";
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.detailTextLabel.text = @"";
                    cell.imageView.image = [UIImage imageNamed:@"FeedBack"];
                    return cell;
                }
                    break;
                case 2:{
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
                    cell.textLabel.text = @"Talk to our CEO";
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.detailTextLabel.text = @"";
                    cell.imageView.image = [UIImage imageNamed:@"Ceo"];
                    return cell;
                }
                    break;
                case 3:{
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
                    cell.textLabel.text = @"Suggest a Feature";
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.detailTextLabel.text = @"";
                    cell.imageView.image = [UIImage imageNamed:@"feature"];
                    return cell;
                }
                    break;
                    
                default:
                    return nil;
                    break;
            }
        }
            break;
            
        case 2:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
            cell.textLabel.text = @"Tell your friends about Uncle Bun";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.text = @"";
            cell.imageView.image = [UIImage imageNamed:@"tell your friends"];
            return cell;
        }
            break;
            
        case 3:{
            switch (indexPath.row) {
                case 0:{
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
                    cell.textLabel.text = @"Terms of Service";
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.detailTextLabel.text = @"";
                    cell.imageView.image = [UIImage imageNamed:@"terms"];
                    return cell;
                }
                    break;
                case 1:{
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
                    cell.textLabel.text = @"Privacy Policy";
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.detailTextLabel.text = @"";
                    cell.imageView.image = [UIImage imageNamed:@"Privacy"];
                    return cell;
                }
                    break;
                    
                case 2:{
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
                    cell.textLabel.text = @"About us";
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.detailTextLabel.text = @"";
                    cell.imageView.image = [UIImage imageNamed:@"About"];
                    return cell;
                }
                    break;
                    
                default:
                    return nil;
                    break;
            }
        }
            break;
            
        case 4:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
            cell.textLabel.text = @"Sign out";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.text = @"";
            cell.imageView.image = [UIImage imageNamed:@"Sign out"];
            return cell;
        }
            break;
            
        default:
            return nil;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 66;
            break;
            
        default:
            return 44;
            break;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"Profile";
            break;
        case 1:
            return @"Help & Feedback";
            break;
        case 2:
            return @"Promote";
            break;
        case 3:
            return @"About";
            break;
            
        default:
            return nil;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:{
            if ([FIRAuth auth].currentUser.isAnonymous) {
                UBSignInViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"UBSignInViewController"];
                [self presentViewController:vc animated:YES completion:nil];
            }
            else{
                
            }
        }
            break;
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:iOS7AppStoreURLFormat, YOUR_APP_STORE_ID]];
                    [[UIApplication sharedApplication] openURL:url];
                }
                    break;
                case 1:{
                    
                }
                    break;
                case 2:{
                    
                }
                    break;
                case 3:{
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:{
            [self share];
        }
            break;
        case 3:{
            switch (indexPath.row) {
                case 0:{
                    
                }
                    break;
                case 1:{
                    
                }
                    break;
                case 2:{
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 4:{
            [self signOut];
        }
            break;
            
        default:
            break;
    }
}

-(void)share{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *facebook = [UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
        content.contentURL = [NSURL URLWithString:[FIRRemoteConfig remoteConfig][itunesAppUrl].stringValue];
        [FBSDKShareDialog showFromViewController:self
                                     withContent:content
                                        delegate:nil];
    }];
    UIAlertAction *sms = [UIAlertAction actionWithTitle:@"SMS" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showSMS];
    }];
    UIAlertAction *email = [UIAlertAction actionWithTitle:@"Email" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showEmail];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:facebook];
    [alert addAction:email];
    [alert addAction:sms];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)signOut{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"Sign out" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSError *error;
        [[FBSDKLoginManager new] logOut];
        [[FIRAuth auth] signOut:&error];
        UBSignInViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"UBSignInViewController"];
        [self presentViewController:vc animated:YES completion:nil];
    }];
    UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:actionYes];
    [alert addAction:actionNo];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showSMS {
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Your device doesn't support SMS!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    NSString *message = [NSString stringWithFormat:@"%@ %@",[FIRRemoteConfig remoteConfig][shareSMSText].stringValue,[FIRRemoteConfig remoteConfig][itunesAppUrl].stringValue];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setBody:message];
    
    [self presentViewController:messageController animated:YES completion:nil];
}

- (void)showEmail {
    
    if (![MFMailComposeViewController canSendMail]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Your device can't send email. Please check email configuration and try again" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    NSString *emailTitle = [FIRRemoteConfig remoteConfig][shareEmailTitle].stringValue;
    
    NSString *messageBody = [NSString stringWithFormat:@"%@ %@",[FIRRemoteConfig remoteConfig][shareEmailText].stringValue,[FIRRemoteConfig remoteConfig][itunesAppUrl].stringValue];
    
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to send SMS!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];

            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
