//
//  ViewController.h
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 27/06/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property NSArray *myCSVArray;

@property (weak, nonatomic) IBOutlet UIPickerView *towerPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *floorPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *wingPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *layoutPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *sideFacingPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *soldPicker;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *recordsLabel;

- (IBAction)segueToGeneratePDF:(id)sender;

@end

