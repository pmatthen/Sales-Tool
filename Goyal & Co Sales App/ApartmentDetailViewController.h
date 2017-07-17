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
@property (weak, nonatomic) IBOutlet UILabel *labelA;
@property (weak, nonatomic) IBOutlet UILabel *labelB;

@property NSString *apartmentComplexLocationString;
@property NSString *apartmentLayoutString;
@property NSString *apartmentString;

- (IBAction)backButtonPressed:(id)sender;

@end
