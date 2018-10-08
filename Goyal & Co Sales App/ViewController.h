//
//  ViewController.h
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 27/06/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import <UIKit/UIKit.h>

// These values are for the PDF generating methods.

#define kBorderInset            20.0
#define kBorderWidth            1.0
#define kMarginInset            10.0
#define kLineWidth              1.0

@interface ViewController : UIViewController {
    CGSize pageSize;
}

@property NSMutableDictionary *apartmentInterestMutableDictionary;
@property NSMutableDictionary *userDictionary;
@property NSMutableArray *keyArray;

@property NSArray *myCSVArray;

@property NSMutableArray *towerArray;
@property NSMutableArray *floorArray;
@property NSMutableArray *wingArray;
@property NSMutableArray *layoutArray;
@property NSMutableArray *directionArray;
@property NSMutableArray *isSoldArray;
@property NSArray *myFilterArray;
@property NSDictionary *myMasterDictionary;
@property NSDictionary *apartmentDetailsDictionary;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *generatePDFButton;
@property (weak, nonatomic) IBOutlet UIButton *customerDetailsButton;

@property (weak, nonatomic) IBOutlet UIPickerView *towerPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *floorPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *wingPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *layoutPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *sideFacingPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *soldPicker;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *recordsLabel;

- (IBAction)segueToGeneratePDF:(id)sender;
- (IBAction)segueToCustomerDetails:(id)sender;
- (IBAction)resetButtonPressed:(id)sender;

@end

