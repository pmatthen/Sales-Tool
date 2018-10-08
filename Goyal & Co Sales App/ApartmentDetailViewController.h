//
//  ApartmentDetailViewController.h
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 10/07/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApartmentDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *apartmentComplexLocationImageView;
@property (weak, nonatomic) IBOutlet UIImageView *apartmentLayoutImageView;
@property (weak, nonatomic) IBOutlet UIImageView *droneImageViewA;
@property (weak, nonatomic) IBOutlet UIImageView *droneImageViewB;
@property (weak, nonatomic) IBOutlet UILabel *droneImageViewALabel;
@property (weak, nonatomic) IBOutlet UILabel *droneImageViewBLabel;
@property (weak, nonatomic) IBOutlet UIButton *lowInterestButton;
@property (weak, nonatomic) IBOutlet UIButton *mediumInterestButton;
@property (weak, nonatomic) IBOutlet UIButton *highInterestButton;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property NSString *apartmentComplexLocationString;
@property NSString *apartmentLayoutString;
@property NSString *apartmentString;
@property NSString *towerString;
@property NSString *wingString;
@property NSString *floorString;
@property NSString *sqftString;

- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)lowInterestButtonPressed:(id)sender;
- (IBAction)mediumInterestButtonPressed:(id)sender;
- (IBAction)highInterestButtonPressed:(id)sender;
- (IBAction)emailCustomerButtonPressed:(id)sender;
- (IBAction)page1ButtonPressed:(id)sender;
- (IBAction)page3ButtonPressed:(id)sender;

@end
