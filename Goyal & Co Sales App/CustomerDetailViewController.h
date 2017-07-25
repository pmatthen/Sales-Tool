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

- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;

@end
