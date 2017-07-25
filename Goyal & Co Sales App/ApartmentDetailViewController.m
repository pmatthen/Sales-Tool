//
//  ApartmentDetailViewController.m
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 10/07/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import "ApartmentDetailViewController.h"

@interface ApartmentDetailViewController ()

@property BOOL isLowInterestButtonPressed;
@property BOOL isMediumInterestButtonPressed;
@property BOOL isHighInterestButtonPressed;

@end

@implementation ApartmentDetailViewController
@synthesize apartmentComplexLocationImageView, apartmentLayoutImageView, droneImageViewA, droneImageViewB, labelA, labelB, lowInterestButton, mediumInterestButton, highInterestButton, apartmentComplexLocationString, apartmentLayoutString, apartmentString, isLowInterestButtonPressed, isMediumInterestButtonPressed, isHighInterestButtonPressed;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lowInterestButton.layer.borderWidth = 2.0f;
    lowInterestButton.layer.borderColor = [UIColor redColor].CGColor;
    [lowInterestButton setBackgroundColor:[UIColor clearColor]];
    
    mediumInterestButton.layer.borderWidth = 2.0f;
    mediumInterestButton.layer.borderColor = [UIColor yellowColor].CGColor;
    [mediumInterestButton setBackgroundColor:[UIColor clearColor]];
    
    highInterestButton.layer.borderWidth = 2.0f;
    highInterestButton.layer.borderColor = [UIColor greenColor].CGColor;
    [highInterestButton setBackgroundColor:[UIColor clearColor]];
    
    isLowInterestButtonPressed = false;
    isMediumInterestButtonPressed = false;
    isHighInterestButtonPressed = false;
    
    NSMutableDictionary *apartmentInterestMutableDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"apartmentInterestMutableDictionary"] mutableCopy];
    
    if ([apartmentInterestMutableDictionary objectForKey:apartmentString] != nil) {
        if ([[apartmentInterestMutableDictionary objectForKey:apartmentString] isEqual:@"Interest Level 1"]) {
            [lowInterestButton setBackgroundColor:[UIColor redColor]];
            isLowInterestButtonPressed = true;
        }
        if ([[apartmentInterestMutableDictionary objectForKey:apartmentString] isEqual:@"Interest Level 2"]) {
            [mediumInterestButton setBackgroundColor:[UIColor yellowColor]];
            isMediumInterestButtonPressed = true;
        }
        if ([[apartmentInterestMutableDictionary objectForKey:apartmentString] isEqual:@"Interest Level 3"]) {
            [highInterestButton setBackgroundColor:[UIColor greenColor]];
            isHighInterestButtonPressed = true;
        }
    }

    NSDictionary *myDirectionsDictionary = [[NSDictionary alloc] initWithDictionary:[self createDirectionDictionary]];
    
    [apartmentComplexLocationImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", apartmentComplexLocationString]]];
    [apartmentLayoutImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", apartmentLayoutString]]];
    
    NSArray *directionsArray = [myDirectionsDictionary objectForKey:apartmentComplexLocationString];
    
    if ([directionsArray count] == 2) {
        [droneImageViewA setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@A.png", apartmentString]]];
        [droneImageViewB setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@B.png", apartmentString]]];
        labelA.text = [directionsArray objectAtIndex:0];
        labelB.text = [directionsArray objectAtIndex:1];
    } else {
        [droneImageViewB removeFromSuperview];
        [labelB removeFromSuperview];
        
        [droneImageViewA setCenter:CGPointMake(self.view.center.x, droneImageViewA.center.y)];
        [labelA setCenter:CGPointMake(droneImageViewA.center.x, labelA.center.y)];
        
        [droneImageViewA setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@A.png", apartmentString]]];
        labelA.text = [directionsArray objectAtIndex:0];
    }
}

- (NSDictionary *) createDirectionDictionary {
    NSMutableDictionary *directionsMutableDictionary = [NSMutableDictionary new];
    
    [directionsMutableDictionary setValue:@[@"North", @"East"] forKey:@"A01"];
    [directionsMutableDictionary setValue:@[@"East"] forKey:@"A02"];
    [directionsMutableDictionary setValue:@[@"West"] forKey:@"A03"];
    [directionsMutableDictionary setValue:@[@"North", @"West"] forKey:@"A04"];

    [directionsMutableDictionary setValue:@[@"East"] forKey:@"B01"];
    [directionsMutableDictionary setValue:@[@"North East", @"South East"] forKey:@"B02"];
    [directionsMutableDictionary setValue:@[@"South East", @"South West"] forKey:@"B03"];
    [directionsMutableDictionary setValue:@[@"South East"] forKey:@"B04"];
    [directionsMutableDictionary setValue:@[@"North West"] forKey:@"B05"];
    [directionsMutableDictionary setValue:@[@"West"] forKey:@"B06"];
    
    [directionsMutableDictionary setValue:@[@"North West"] forKey:@"C01"];
    [directionsMutableDictionary setValue:@[@"South East"] forKey:@"C02"];
    [directionsMutableDictionary setValue:@[@"East"] forKey:@"C03"];
    [directionsMutableDictionary setValue:@[@"West"] forKey:@"C04"];
    [directionsMutableDictionary setValue:@[@"South West", @"North West"] forKey:@"C05"];
    [directionsMutableDictionary setValue:@[@"North West", @"North East"] forKey:@"C06"];
    
    [directionsMutableDictionary setValue:@[@"East"] forKey:@"D01"];
    [directionsMutableDictionary setValue:@[@"North East", @"South East"] forKey:@"D02"];
    [directionsMutableDictionary setValue:@[@"South East", @"South West"] forKey:@"D03"];
    [directionsMutableDictionary setValue:@[@"South East"] forKey:@"D04"];
    [directionsMutableDictionary setValue:@[@"North West"] forKey:@"D05"];
    [directionsMutableDictionary setValue:@[@"West"] forKey:@"D06"];

    [directionsMutableDictionary setValue:@[@"North West"] forKey:@"E01"];
    [directionsMutableDictionary setValue:@[@"South East"] forKey:@"E02"];
    [directionsMutableDictionary setValue:@[@"East", @"South"] forKey:@"E03"];
    [directionsMutableDictionary setValue:@[@"West", @"South"] forKey:@"E04"];
    [directionsMutableDictionary setValue:@[@"North West", @"South West"] forKey:@"E05"];
    [directionsMutableDictionary setValue:@[@"North East", @"North West"] forKey:@"E06"];
    
    NSDictionary *directionsDictionary = [[NSDictionary alloc] initWithDictionary:[directionsMutableDictionary copy]];
    
    return directionsDictionary;
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)lowInterestButtonPressed:(id)sender {
    
    if (!isLowInterestButtonPressed) {
        [lowInterestButton setBackgroundColor:[UIColor redColor]];
        [mediumInterestButton setBackgroundColor:[UIColor clearColor]];
        [highInterestButton setBackgroundColor:[UIColor clearColor]];
        
        isLowInterestButtonPressed = true;
        isMediumInterestButtonPressed = false;
        isHighInterestButtonPressed = false;
        
        NSMutableDictionary *apartmentInterestMutableDictionary = [[NSMutableDictionary alloc] init];
        apartmentInterestMutableDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"apartmentInterestMutableDictionary"] mutableCopy];
        
        [apartmentInterestMutableDictionary setObject:@"Interest Level 1" forKey:apartmentString];
        [[NSUserDefaults standardUserDefaults] setObject:apartmentInterestMutableDictionary forKey:@"apartmentInterestMutableDictionary"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        [lowInterestButton setBackgroundColor:[UIColor clearColor]];
        isLowInterestButtonPressed = false;
    }
}

- (IBAction)mediumInterestButtonPressed:(id)sender {
    if (!isMediumInterestButtonPressed) {
        [mediumInterestButton setBackgroundColor:[UIColor yellowColor]];
        [lowInterestButton setBackgroundColor:[UIColor clearColor]];
        [highInterestButton setBackgroundColor:[UIColor clearColor]];
        
        isMediumInterestButtonPressed = true;
        isLowInterestButtonPressed = false;
        isHighInterestButtonPressed = false;
        
        NSMutableDictionary *apartmentInterestMutableDictionary = [[NSMutableDictionary alloc] init];
        apartmentInterestMutableDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"apartmentInterestMutableDictionary"] mutableCopy];
        
        [apartmentInterestMutableDictionary setObject:@"Interest Level 2" forKey:apartmentString];
        [[NSUserDefaults standardUserDefaults] setObject:apartmentInterestMutableDictionary forKey:@"apartmentInterestMutableDictionary"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [mediumInterestButton setBackgroundColor:[UIColor clearColor]];
        isMediumInterestButtonPressed = false;
    }
}

- (IBAction)highInterestButtonPressed:(id)sender {
    if (!isHighInterestButtonPressed) {
        [highInterestButton setBackgroundColor:[UIColor greenColor]];
        [lowInterestButton setBackgroundColor:[UIColor clearColor]];
        [mediumInterestButton setBackgroundColor:[UIColor clearColor]];
        
        isHighInterestButtonPressed = true;
        isLowInterestButtonPressed = false;
        isMediumInterestButtonPressed = false;
        
        NSMutableDictionary *apartmentInterestMutableDictionary = [[NSMutableDictionary alloc] init];
        apartmentInterestMutableDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"apartmentInterestMutableDictionary"] mutableCopy];
        
        [apartmentInterestMutableDictionary setObject:@"Interest Level 3" forKey:apartmentString];
        [[NSUserDefaults standardUserDefaults] setObject:apartmentInterestMutableDictionary forKey:@"apartmentInterestMutableDictionary"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [highInterestButton setBackgroundColor:[UIColor clearColor]];
        isHighInterestButtonPressed = false;
    }
}

@end
