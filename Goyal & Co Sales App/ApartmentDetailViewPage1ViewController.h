//
//  ApartmentDetailViewPage1ViewController.h
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 21/09/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApartmentDetailViewPage1ViewController : UIViewController

@property NSString *apartmentComplexLocationString;
@property NSString *apartmentLayoutString;
@property NSString *apartmentString;
@property NSString *towerString;
@property NSString *wingString;
@property NSString *floorString;
@property NSString *sqftString;

@property (weak, nonatomic) IBOutlet UILabel *towerInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *floorInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *apartmentInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *layoutInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectCompletionInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *startingFromInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *lowInterestButton;
@property (weak, nonatomic) IBOutlet UIButton *mediumInterestButton;
@property (weak, nonatomic) IBOutlet UIButton *highInterestButton;

- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)page2ButtonPressed:(id)sender;
- (IBAction)lowInterestButtonPressed:(id)sender;
- (IBAction)mediumInterestButtonPressed:(id)sender;
- (IBAction)highInterestButtonPressed:(id)sender;
- (IBAction)emailCustomerButtonPressed:(id)sender;

@end
