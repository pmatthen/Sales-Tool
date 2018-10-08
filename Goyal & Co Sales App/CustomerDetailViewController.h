//
//  CustomerDetailViewController.h
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 19/07/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property NSDictionary *masterDictionary;

- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;

@end
