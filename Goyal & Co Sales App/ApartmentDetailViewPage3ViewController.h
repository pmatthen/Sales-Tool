//
//  ApartmentDetailViewPage3ViewController.h
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 21/09/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApartmentDetailViewPage3ViewController : UIViewController

@property NSString *apartmentComplexLocationString;
@property NSString *apartmentLayoutString;
@property NSString *apartmentString;
@property NSString *towerString;
@property NSString *wingString;
@property NSString *floorString;
@property NSString *sqftString;

@property (weak, nonatomic) IBOutlet UIButton *lowInterestButton;
@property (weak, nonatomic) IBOutlet UIButton *mediumInterestButton;
@property (weak, nonatomic) IBOutlet UIButton *highInterestButton;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)page2ButtonPressed:(id)sender;
- (IBAction)lowInterestButtonPressed:(id)sender;
- (IBAction)mediumInterestButtonPressed:(id)sender;
- (IBAction)highInterestButtonPressed:(id)sender;
- (IBAction)emailCustomerButtonPressed:(id)sender;

@end
