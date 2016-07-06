//
//  UBLocationViewController.m
//  Uncle Bun
//
//  Created by Abbin Varghese on 06/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "UBLocationViewController.h"
#import "NSMutableDictionary+TFALocation.h"

@interface UBLocationViewController ()<UITableViewDelegate,UITableViewDataSource,GMSAutocompleteFetcherDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) GMSAutocompleteFetcher *fetcher;
@property (strong, nonatomic) NSArray *listArray;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

@implementation UBLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_searchBar becomeFirstResponder];
    
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    filter.country = countryCode;
    self.fetcher = [[GMSAutocompleteFetcher alloc] initWithBounds:nil filter:filter];
    self.fetcher.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else{
        return self.listArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"Detect my location";
        cell.detailTextLabel.text = @"";
        cell.imageView.image = [UIImage imageNamed:@"Current Location"];
    }
    else{
        GMSAutocompletePrediction *prediction = [self.listArray objectAtIndex:indexPath.row];
        cell.textLabel.attributedText = prediction.attributedPrimaryText;
        cell.detailTextLabel.attributedText = prediction.attributedSecondaryText;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.height/10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [_activityIndicator startAnimating];
        [[GMSPlacesClient sharedClient] currentPlaceWithCallback:^(GMSPlaceLikelihoodList * _Nullable likelihoodList, NSError * _Nullable error) {
            if (error == nil) {
                GMSPlaceLikelihood *likelihood = [likelihoodList.likelihoods objectAtIndex:0];
                GMSPlace* place = likelihood.place;
                NSMutableDictionary *obj = [[NSMutableDictionary alloc]initWithGMSPlace:place];
                [_activityIndicator stopAnimating];
                [self dismissViewControllerAnimated:YES completion:^{
                    if ([self.delegate respondsToSelector:@selector(UBLocation:didFinishGettingLocation:)]) {
                        [self.delegate UBLocation:self didFinishGettingLocation:obj];
                    }
                }];
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
    else{
        [_activityIndicator startAnimating];
        GMSAutocompletePrediction *prediction = [self.listArray objectAtIndex:indexPath.row];
        
        [[GMSPlacesClient sharedClient] lookUpPlaceID:prediction.placeID callback:^(GMSPlace * _Nullable result, NSError * _Nullable error) {
            if (error == nil) {
                [_activityIndicator stopAnimating];
                NSMutableDictionary *obj = [[NSMutableDictionary alloc]initWithGMSPlace:result];
                [self dismissViewControllerAnimated:YES completion:^{
                    if ([self.delegate respondsToSelector:@selector(UBLocation:didFinishGettingLocation:)]) {
                        [self.delegate UBLocation:self didFinishGettingLocation:obj];
                    }
                }];
            }
            else{
                [_activityIndicator stopAnimating];
                UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to get location" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.label.text = @"";
    [self.activityIndicator startAnimating];
    [self.fetcher sourceTextHasChanged:searchText];
}

- (void)didAutocompleteWithPredictions:(NSArray *)predictions {
    [self.activityIndicator stopAnimating];
    
    if (predictions.count>0) {
        self.label.text = @"";
    }
    else{
        self.label.text = @"No results found";
    }
    self.listArray = predictions;
    [self.listTableView reloadData];
}

- (void)didFailAutocompleteWithError:(NSError *)error {
    self.label.text = @"No results found";
}


@end
