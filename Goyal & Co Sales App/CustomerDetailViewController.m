//
//  CustomerDetailViewController.m
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 19/07/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import "CustomerDetailViewController.h"
#import "CustomerDetailTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface CustomerDetailViewController ()

@property NSMutableDictionary *apartmentInterestMutableDictionary;
@property NSMutableDictionary *userDictionary;
@property NSMutableArray *keyArray;

@end

@implementation CustomerDetailViewController
@synthesize nameTextField, emailTextField, phoneTextField, myTableView, backButton, saveButton, apartmentInterestMutableDictionary, userDictionary, keyArray, masterDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"myMasterDictionary = %@", masterDictionary);
    
    backButton.layer.borderWidth = 2.0f;
    backButton.layer.borderColor = [UIColor whiteColor].CGColor;
    backButton.frame = CGRectMake(backButton.frame.origin.x, backButton.frame.origin.y, (backButton.frame.size.width + 40), (backButton.frame.size.height + 10));
    
    saveButton.layer.borderWidth = 2.0f;
    saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
    saveButton.frame = CGRectMake(saveButton.frame.origin.x, saveButton.frame.origin.y, (saveButton.frame.size.width + 40), (saveButton.frame.size.height + 10));
    
    [self SetTextFieldBorder:nameTextField];
    [self SetTextFieldBorder:emailTextField];
    [self SetTextFieldBorder:phoneTextField];

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

-(void)SetTextFieldBorder :(UITextField *)textField {
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor blackColor].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;
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
    
    NSDictionary *detailsDictionary = [NSDictionary new];
    detailsDictionary = [self textForLabels:[keyArray objectAtIndex:indexPath.row]];
    
    cell.apartmentLabel.text = [keyArray objectAtIndex:indexPath.row];
    cell.layoutLabel.text = [detailsDictionary valueForKey:@"Layout"];
    cell.sideFacingLabel.text = [detailsDictionary valueForKey:@"Direction"];
    cell.soldLabel.text = [detailsDictionary valueForKey:@"IsSold"];
    cell.interestLabel.text = [apartmentInterestMutableDictionary objectForKey:[keyArray objectAtIndex:indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSDictionary *) textForLabels:(NSString *)apartmentString {
    NSString *towerString = [apartmentString substringToIndex:1];
    NSString *floorString = [apartmentString substringWithRange:NSMakeRange(1,2)];
    NSString *wingString = [apartmentString substringWithRange:NSMakeRange(3,2)];
    
    NSDictionary *tempApartmentDictionary = [masterDictionary valueForKeyPath:[NSString stringWithFormat:@"%@.%@.%@.%@%@", towerString, floorString, wingString, floorString, wingString]];
    
    return tempApartmentDictionary;
}


- (IBAction)saveButtonPressed:(id)sender {
    
    if (([nameTextField.text length] > 0) && ([emailTextField.text length] > 0) && ([phoneTextField.text length] > 0)) {
        if ([nameTextField.text length] > 0) {
            [userDictionary setObject:nameTextField.text forKey:@"name"];
        }
        if ([emailTextField.text length] > 0) {
            if ([self validateEmailWithString:emailTextField.text]) {
                [userDictionary setObject:emailTextField.text forKey:@"email"];
                
                if ([phoneTextField.text length] > 0) {
                    [userDictionary setObject:phoneTextField.text forKey:@"phone"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:userDictionary forKey:@"userDictionary"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Details have been saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter a valid phone number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                }
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter a valid email address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please fill in all the fields." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
