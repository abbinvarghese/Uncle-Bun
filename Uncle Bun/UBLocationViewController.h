//
//  UBLocationViewController.h
//  Uncle Bun
//
//  Created by Abbin Varghese on 06/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UBLocationViewController;
@protocol UBLocationDelegate <NSObject>

-(void)UBLocation:(UBLocationViewController*)controller didFinishGettingLocation:(NSMutableDictionary*)location;

@end

@interface UBLocationViewController : UIViewController

@property (strong, nonatomic) id <UBLocationDelegate> delegate;

@end
