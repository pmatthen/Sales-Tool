//
//  ApartmentDetailViewController.m
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 10/07/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import "ApartmentDetailViewController.h"

@interface ApartmentDetailViewController ()

@end

@implementation ApartmentDetailViewController
@synthesize apartmentComplexLocationImageView, apartmentLayoutImageView, droneImageViewA, droneImageViewB, labelA, labelB, apartmentComplexLocationString, apartmentLayoutString, apartmentString;

- (void)viewDidLoad {
    [super viewDidLoad];

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

@end
