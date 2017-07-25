//
//  CustomerDetailViewController.m
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 19/07/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import "CustomerDetailViewController.h"
#import "CustomerDetailTableViewCell.h"

@interface CustomerDetailViewController ()

@property NSMutableDictionary *apartmentInterestMutableDictionary;
@property NSMutableDictionary *userDictionary;
@property NSMutableArray *keyArray;

@end

@implementation CustomerDetailViewController
@synthesize nameTextField, emailTextField, phoneTextField, myTableView, apartmentInterestMutableDictionary, userDictionary, keyArray;

- (void)viewDidLoad {
    [super viewDidLoad];

    userDictionary = [NSMutableDictionary new];
    userDictionary = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"userDictionary"]];
    
    if ([userDictionary objectForKey:@"name"] != nil) {
        nameTextField.text = [userDictionary objectForKey:@"name"];
    }
    if ([userDictionary objectForKey:@"email"] != nil) {
        emailTextField.text = [userDictionary objectForKey:@"email"];
    }
    if ([userDictionary objectForKey:@"phone"] != nil) {
        phoneTextField.text = [userDictionary objectForKey:@"phone"];
    }
    
    apartmentInterestMutableDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"apartmentInterestMutableDictionary"] mutableCopy];
    
    keyArray = [[NSMutableArray alloc] initWithArray:[apartmentInterestMutableDictionary allKeys]];
    
    [keyArray sortUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        return [str1 compare:str2 options:(NSNumericSearch)];
    }];
}

- (BOOL)validateEmailWithString:(NSString*)checkString {
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [keyArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomerDetailTableViewCell *cell = (CustomerDetailTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"CustomerDetailCell"];
    
    cell.apartmentLabel.text = [keyArray objectAtIndex:indexPath.row];
    cell.interestLabel.text = [apartmentInterestMutableDictionary objectForKey:[keyArray objectAtIndex:indexPath.row]];
    
    return cell;
}


- (IBAction)saveButtonPressed:(id)sender {
    
    if (([nameTextField.text length] > 0) && ([emailTextField.text length] > 0) && ([phoneTextField.text length] > 0)) {
        if ([nameTextField.text length] > 0) {
            [userDictionary setObject:nameTextField.text forKey:@"name"];
        }
        if ([emailTextField.text length] > 0) {
            if ([self validateEmailWithString:emailTextField.text]) {
                [userDictionary setObject:emailTextField.text forKey:@"email"];
            } else {
                NSLog(@"Please enter a valid email address");
            }
        }
        if ([phoneTextField.text length] > 0) {
            [userDictionary setObject:phoneTextField.text forKey:@"phone"];
        }
        [[NSUserDefaults standardUserDefaults] setObject:userDictionary forKey:@"userDictionary"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        NSLog(@"Please fill in fields");
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
