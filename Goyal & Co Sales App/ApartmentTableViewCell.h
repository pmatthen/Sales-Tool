//
//  ApartmentTableViewCell.h
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 07/07/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApartmentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *apartmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *towerLabel;
@property (weak, nonatomic) IBOutlet UILabel *wingLabel;
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;
@property (weak, nonatomic) IBOutlet UILabel *layoutLabel;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;
@property (weak, nonatomic) IBOutlet UILabel *soldLabel;

@end
