//
//  CustomerDetailTableViewCell.h
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 19/07/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *apartmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *layoutLabel;
@property (weak, nonatomic) IBOutlet UILabel *sideFacingLabel;
@property (weak, nonatomic) IBOutlet UILabel *soldLabel;
@property (weak, nonatomic) IBOutlet UILabel *interestLabel;

@end
