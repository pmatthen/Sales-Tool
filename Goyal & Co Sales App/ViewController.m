//
//  ViewController.m
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 27/06/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import "ViewController.h"
#import "ApartmentTableViewCell.h"
#import "ApartmentDetailViewController.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate>
 
@property NSMutableArray *towerArray;
@property NSMutableArray *floorArray;
@property NSMutableArray *wingArray;
@property NSMutableArray *layoutArray;
@property NSMutableArray *directionArray;
@property NSMutableArray *isSoldArray;
@property NSArray *myFilterArray;
@property NSDictionary *myMasterDictionary;
@property NSDictionary *apartmentDetailsDictionary;

@end

@implementation ViewController
@synthesize myCSVArray, towerPicker, floorPicker, wingPicker, layoutPicker, sideFacingPicker, soldPicker, myTableView, recordsLabel, towerArray, floorArray, wingArray, layoutArray, directionArray, isSoldArray, myFilterArray, myMasterDictionary, apartmentDetailsDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    myMasterDictionary = [[NSDictionary alloc] initWithDictionary:[self buildNSDictionaryfromNSArray:myCSVArray]];
    NSLog(@"myMasterDictionary = %@", myMasterDictionary);
    myFilterArray = [[NSArray alloc] initWithArray:[self buildFilterArrayFromTower:@"-" andFloor:@"-" andWing:@"-" andLayout:@"-" andSideFacing:@"-" andIsSold:@"-" andMasterDictionary:myMasterDictionary]];
    
    [towerPicker reloadAllComponents];
    [floorPicker reloadAllComponents];
    [wingPicker reloadAllComponents];
    [layoutPicker reloadAllComponents];
    [sideFacingPicker reloadAllComponents];
    [soldPicker reloadAllComponents];
    
    [myTableView reloadData];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == towerPicker) {
        return [towerArray count];
    }
    if (pickerView == floorPicker) {
        return [floorArray count];
    }
    if (pickerView == wingPicker) {
        return [wingArray count];
    }
    if (pickerView == layoutPicker) {
        return [layoutArray count];
    }
    if (pickerView == sideFacingPicker) {
        return [directionArray count];
    }
    if (pickerView == soldPicker) {
        return [isSoldArray count];
    }
    
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == towerPicker) {
        return [NSString stringWithFormat:@"%@", towerArray[row]];
    }
    if (pickerView == floorPicker) {
        return [NSString stringWithFormat:@"%@", floorArray[row]];
    }
    if (pickerView == wingPicker) {
        return [NSString stringWithFormat:@"%@", wingArray[row]];
    }
    if (pickerView == layoutPicker) {
        return [NSString stringWithFormat:@"%@", layoutArray[row]];
    }
    if (pickerView == sideFacingPicker) {
        return [NSString stringWithFormat:@"%@", directionArray[row]];
    }
    if (pickerView == soldPicker) {
        return [NSString stringWithFormat:@"%@", isSoldArray[row]];
    }
    
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString *towerFilter = [towerArray objectAtIndex:[towerPicker selectedRowInComponent:0]];
    NSString *floorFilter = [floorArray objectAtIndex:[floorPicker selectedRowInComponent:0]];
    NSString *wingFilter = [wingArray objectAtIndex:[wingPicker selectedRowInComponent:0]];
    NSString *layoutFilter = [layoutArray objectAtIndex:[layoutPicker selectedRowInComponent:0]];
    NSString *directionFilter = [directionArray objectAtIndex:[sideFacingPicker selectedRowInComponent:0]];
    NSString *isSoldFilter = [isSoldArray objectAtIndex:[soldPicker selectedRowInComponent:0]];
    
    myFilterArray = [[NSArray alloc] initWithArray:[self buildFilterArrayFromTower:towerFilter andFloor:floorFilter andWing:wingFilter andLayout:layoutFilter andSideFacing:directionFilter andIsSold:isSoldFilter andMasterDictionary:myMasterDictionary]];
    
    [myTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    recordsLabel.text = [NSString stringWithFormat:@"%lu Matches", (unsigned long)[myFilterArray count]];
    
    recordsLabel.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0.2 options:UIViewAnimationOptionAutoreverse animations:^{
        [UIView setAnimationRepeatCount:0];
        recordsLabel.alpha = 1;
    } completion:nil];
    
    return [myFilterArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ApartmentTableViewCell *cell = (ApartmentTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    NSDictionary *tempApartmentDictionary = [[NSDictionary alloc] initWithDictionary:[myFilterArray objectAtIndex:indexPath.row]];
    
    cell.apartmentLabel.text = [tempApartmentDictionary objectForKey:@"Apartment"];
    cell.towerLabel.text = [tempApartmentDictionary objectForKey:@"Tower"];
    cell.floorLabel.text = [tempApartmentDictionary objectForKey:@"Floor"];
    cell.wingLabel.text = [tempApartmentDictionary objectForKey:@"Wing"];
    cell.layoutLabel.text = [tempApartmentDictionary objectForKey:@"Layout"];
    cell.directionLabel.text = [tempApartmentDictionary objectForKey:@"Direction"];
    cell.soldLabel.text = [tempApartmentDictionary objectForKey:@"IsSold"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    apartmentDetailsDictionary = [myFilterArray objectAtIndex:indexPath.row];
    NSLog(@"apartmentDetailsDictionary = %@", apartmentDetailsDictionary);
    [self performSegueWithIdentifier:@"DetailViewSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailViewSegue"]) {
        ApartmentDetailViewController *myApartmentDetailViewController = (ApartmentDetailViewController *) segue.destinationViewController;
        
        NSString *apartmentFloorAndNumber = [apartmentDetailsDictionary objectForKey:@"Apartment"];
        NSString *apartmentNumber = [apartmentFloorAndNumber substringFromIndex: [apartmentFloorAndNumber length] - 2];
        
        myApartmentDetailViewController.apartmentComplexLocationString = [NSString stringWithFormat:@"%@%@", [apartmentDetailsDictionary objectForKey:@"Tower"], apartmentNumber];
        myApartmentDetailViewController.apartmentLayoutString = [apartmentDetailsDictionary objectForKey:@"Layout"];
        myApartmentDetailViewController.apartmentString = [NSString stringWithFormat:@"%@%@", [apartmentDetailsDictionary objectForKey:@"Tower"], [apartmentDetailsDictionary objectForKey:@"Apartment"]];
    }
}

- (NSDictionary *) buildNSDictionaryfromNSArray:(NSArray *)myCSVArrayInput {
    
    NSMutableDictionary *masterMutableDictionary = [NSMutableDictionary new];
    
    towerArray = [NSMutableArray new];
    [towerArray addObject:@"-"];
    floorArray = [NSMutableArray new];
    [floorArray addObject:@"-"];
    wingArray = [NSMutableArray new];
    [wingArray addObject:@"-"];
    layoutArray = [NSMutableArray new];
    [layoutArray addObject:@"-"];
    directionArray = [NSMutableArray new];
    [directionArray addObject:@"-"];
    isSoldArray = [NSMutableArray new];
    [isSoldArray addObject:@"-"];
    [isSoldArray addObject:@"Y"];
    
    for (int i = 0; i < [myCSVArrayInput count]; i++) {
        //Build Apartment Dictionary
        
        NSArray *apartmentArray = [[NSArray alloc] initWithArray:myCSVArray[i]];
        
        NSString *wing = apartmentArray[2];
        wing = [wing substringFromIndex: [wing length] - 2];
        
        NSMutableDictionary *myApartmentDictionary = [NSMutableDictionary new];
        [myApartmentDictionary setObject:apartmentArray[0] forKey:@"Tower"];
        [myApartmentDictionary setObject:apartmentArray[1] forKey:@"Floor"];
        [myApartmentDictionary setObject:wing forKey:@"Wing"];
        [myApartmentDictionary setObject:apartmentArray[2] forKey:@"Apartment"];
        [myApartmentDictionary setObject:apartmentArray[3] forKey:@"Layout"];
        [myApartmentDictionary setObject:apartmentArray[4] forKey:@"SQFT"];
        [myApartmentDictionary setObject:apartmentArray[5] forKey:@"Direction"];
        [myApartmentDictionary setObject:apartmentArray[6] forKey:@"IsSold"];
        
        if (![towerArray containsObject:[myApartmentDictionary valueForKey:@"Tower"]]) {
            [towerArray addObject:[myApartmentDictionary valueForKey:@"Tower"]];
        }
        if (![floorArray containsObject:[myApartmentDictionary valueForKey:@"Floor"]]) {
            [floorArray addObject:[myApartmentDictionary valueForKey:@"Floor"]];
        }
        if (![wingArray containsObject:[myApartmentDictionary valueForKey:@"Wing"]]) {
            [wingArray addObject:[myApartmentDictionary valueForKey:@"Wing"]];
        }
        if (![layoutArray containsObject:[myApartmentDictionary valueForKey:@"Layout"]]) {
            [layoutArray addObject:[myApartmentDictionary valueForKey:@"Layout"]];
        }
        if (![directionArray containsObject:[myApartmentDictionary valueForKey:@"Direction"]]) {
            [directionArray addObject:[myApartmentDictionary valueForKey:@"Direction"]];
        }
        if (![isSoldArray containsObject:[myApartmentDictionary valueForKey:@"IsSold"]]) {
            [isSoldArray addObject:[myApartmentDictionary valueForKey:@"IsSold"]];
        }
        
        NSMutableDictionary *towerDictionary = [NSMutableDictionary new];
        NSMutableDictionary *floorDictionary = [NSMutableDictionary new];
        NSMutableDictionary *wingDictionary = [NSMutableDictionary new];
        NSMutableDictionary *apartmentDictionary = [NSMutableDictionary new];
        
        //Check if Tower exists in Master Dictionary
        if ([masterMutableDictionary objectForKey:[myApartmentDictionary objectForKey:@"Tower"]] != nil) {
            // Yes - Check if Floor exists in Tower Dictionary
            towerDictionary = [masterMutableDictionary objectForKey:[myApartmentDictionary objectForKey:@"Tower"]];
            if ([towerDictionary objectForKey:[myApartmentDictionary objectForKey:@"Floor"]] != nil) {
                // Yes - Check if Apartment exists in Floor Dictionary
                floorDictionary = [towerDictionary objectForKey:[myApartmentDictionary objectForKey:@"Floor"]];
                if ([floorDictionary objectForKey:[myApartmentDictionary objectForKey:@"Wing"]] != nil) {
                    wingDictionary = [floorDictionary objectForKey:[myApartmentDictionary objectForKey:@"Wing"]];
                    if ([wingDictionary objectForKey:[myApartmentDictionary objectForKey:@"Apartment"]] != nil) {
                        // Yes - Raise Flag
                        NSLog(@"FLAG on floorDictionary = %@", floorDictionary);
                    } else {
                        // No - Create Apartment Dictionary and insert into Wing Dictionary into Floor Dictionary into Tower Dictionary into Master Dictionary
                        [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"Layout"] forKey:@"Layout"];
                        [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"SQFT"] forKey:@"SQFT"];
                        [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"Direction"] forKey:@"Direction"];
                        [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"IsSold"] forKey:@"IsSold"];
                        
                        [wingDictionary setObject:apartmentDictionary forKey:[myApartmentDictionary objectForKey:@"Apartment"]];
                        [floorDictionary setObject:wingDictionary forKey:[myApartmentDictionary objectForKey:@"Wing"]];
                        [towerDictionary setObject:floorDictionary forKey:[myApartmentDictionary objectForKey:@"Floor"]];
                        [masterMutableDictionary setObject:towerDictionary forKey:[myApartmentDictionary objectForKey:@"Tower"]];
                    }
                } else {
                    // No - Insert Floor into Tower Dictionary
                    [floorDictionary setObject:[myApartmentDictionary objectForKey:@"Wing"] forKey:[myApartmentDictionary objectForKey:@"Wing"]];
                    [towerDictionary setObject:[myApartmentDictionary objectForKey:@"Floor"] forKey:[myApartmentDictionary objectForKey:@"Floor"]];
                    [masterMutableDictionary setObject:towerDictionary forKey:[myApartmentDictionary objectForKey:@"Tower"]];
                    
                    [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"Layout"] forKey:@"Layout"];
                    [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"SQFT"] forKey:@"SQFT"];
                    [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"Direction"] forKey:@"Direction"];
                    [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"IsSold"] forKey:@"IsSold"];
                    
                    [wingDictionary setObject:apartmentDictionary forKey:[myApartmentDictionary objectForKey:@"Apartment"]];
                    [floorDictionary setObject:wingDictionary forKey:[myApartmentDictionary objectForKey:@"Wing"]];
                    [towerDictionary setObject:floorDictionary forKey:[myApartmentDictionary objectForKey:@"Floor"]];
                    [masterMutableDictionary setObject:towerDictionary forKey:[myApartmentDictionary objectForKey:@"Tower"]];
                }
            } else {
                // No - Insert Floor into Tower Dictionary
                [towerDictionary setObject:[myApartmentDictionary objectForKey:@"Floor"] forKey:[myApartmentDictionary objectForKey:@"Floor"]];
                [masterMutableDictionary setObject:towerDictionary forKey:[myApartmentDictionary objectForKey:@"Tower"]];
                
                [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"Layout"] forKey:@"Layout"];
                [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"SQFT"] forKey:@"SQFT"];
                [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"Direction"] forKey:@"Direction"];
                [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"IsSold"] forKey:@"IsSold"];
                
                [wingDictionary setObject:apartmentDictionary forKey:[myApartmentDictionary objectForKey:@"Apartment"]];
                [floorDictionary setObject:wingDictionary forKey:[myApartmentDictionary objectForKey:@"Wing"]];
                [towerDictionary setObject:floorDictionary forKey:[myApartmentDictionary objectForKey:@"Floor"]];
                [masterMutableDictionary setObject:towerDictionary forKey:[myApartmentDictionary objectForKey:@"Tower"]];
            }
        } else {
            // No - Insert Tower into Master Dictionary
            [masterMutableDictionary setObject:towerDictionary forKey:[myApartmentDictionary objectForKey:@"Tower"]];
            
            [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"Layout"] forKey:@"Layout"];
            [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"SQFT"] forKey:@"SQFT"];
            [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"Direction"] forKey:@"Direction"];
            [apartmentDictionary setObject:[myApartmentDictionary objectForKey:@"IsSold"] forKey:@"IsSold"];
            
            [wingDictionary setObject:apartmentDictionary forKey:[myApartmentDictionary objectForKey:@"Apartment"]];
            [floorDictionary setObject:wingDictionary forKey:[myApartmentDictionary objectForKey:@"Wing"]];
            [towerDictionary setObject:floorDictionary forKey:[myApartmentDictionary objectForKey:@"Floor"]];
            [masterMutableDictionary setObject:towerDictionary forKey:[myApartmentDictionary objectForKey:@"Tower"]];
        }
    }
    
    NSDictionary *masterDictionary = [[NSDictionary alloc] initWithDictionary:[masterMutableDictionary copy]];
    return masterDictionary;
}

-(NSArray *) buildFilterArrayFromTower:(NSString *)myTower andFloor:(NSString *)myFloor andWing:(NSString *)myWing andLayout:(NSString *)myLayout andSideFacing:(NSString *)mySideFacing andIsSold:(NSString *)myIsSold andMasterDictionary:(NSDictionary *)inputMasterDictionary {
    
    NSMutableDictionary *filterMutableDictionary = [NSMutableDictionary new];
    filterMutableDictionary = [inputMasterDictionary mutableCopy];
    
    // Remove unselected towers from dictionary
    if (![myTower isEqualToString:@"-"]) {
        NSArray *towerKeyArray = [[NSArray alloc] initWithArray:[filterMutableDictionary allKeys]];
        for (int i = 0; i < [towerKeyArray count]; i++) {
            if (![myTower isEqualToString:[towerKeyArray objectAtIndex:i]]) {
                [filterMutableDictionary removeObjectForKey:[towerKeyArray objectAtIndex:i]];
            }
        }
    }
    
    NSArray *towerKeyArray = [[NSArray alloc] initWithArray:[filterMutableDictionary allKeys]];
    for (int x = 0; x < [towerKeyArray count]; x++) {
        NSMutableDictionary *myTowerMutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:[filterMutableDictionary objectForKey:[towerKeyArray objectAtIndex:x]]];
        
        // Remove unselected floors
        if (![myFloor isEqualToString:@"-"]) {
            NSArray *floorKeyArray = [[NSArray alloc] initWithArray:[myTowerMutableDictionary allKeys]];
            
            for (int i = 0; i < [floorKeyArray count]; i++) {
                if (![myFloor isEqualToString:[floorKeyArray objectAtIndex:i]]) {
                    [myTowerMutableDictionary removeObjectForKey:[floorKeyArray objectAtIndex:i]];
                }
            }
        }
        
        NSArray *floorkeyArray = [[NSArray alloc] initWithArray:[myTowerMutableDictionary allKeys]];
        for (int y = 0; y < [floorkeyArray count]; y++) {
            NSMutableDictionary *myFloorMutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:[myTowerMutableDictionary objectForKey:[floorkeyArray objectAtIndex:y]]];
            
            // Remove unselected wings
            if (![myWing isEqualToString:@"-"]) {
                NSArray *wingKeyArray = [[NSArray alloc] initWithArray:[myFloorMutableDictionary allKeys]];
                
                for (int i = 0; i < [wingKeyArray count]; i++) {
                    if (![myWing isEqualToString:[wingKeyArray objectAtIndex:i]]) {
                        [myFloorMutableDictionary removeObjectForKey:[wingKeyArray objectAtIndex:i]];
                    }
                }
            }
            
            NSArray *wingKeyArray = [[NSArray alloc] initWithArray:[myFloorMutableDictionary allKeys]];
            for (int z = 0; z < [wingKeyArray count]; z++) {
                NSMutableDictionary *myWingMutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:[myFloorMutableDictionary objectForKey:[wingKeyArray objectAtIndex:z]]];
                
                NSArray *apartmentKeyArray = [[NSArray alloc] initWithArray:[myWingMutableDictionary allKeys]];
                if (![myLayout isEqualToString:@"-"]) {
                    for (int i = 0; i < [apartmentKeyArray count]; i++) {
                        NSMutableDictionary *myApartmentDictionary = [NSMutableDictionary new];
                        myApartmentDictionary = [myWingMutableDictionary objectForKey:[apartmentKeyArray objectAtIndex:i]];
                        
                        if (![myLayout isEqualToString:[myApartmentDictionary objectForKey:@"Layout"]]) {
                            [myWingMutableDictionary removeObjectForKey:[apartmentKeyArray objectAtIndex:i]];
                        }
                    }
                }
                
                if (![mySideFacing isEqualToString:@"-"]) {
                    apartmentKeyArray = [myWingMutableDictionary allKeys];
                    for (int i = 0; i < [apartmentKeyArray count]; i++) {
                        NSMutableDictionary *myApartmentDictionary = [NSMutableDictionary new];
                        myApartmentDictionary = [myWingMutableDictionary objectForKey:[apartmentKeyArray objectAtIndex:i]];
                        
                        if (![mySideFacing isEqualToString:[myApartmentDictionary objectForKey:@"Direction"]]) {
                            [myWingMutableDictionary removeObjectForKey:[apartmentKeyArray objectAtIndex:i]];
                        }
                    }
                }
                
                if (![myIsSold isEqualToString:@"-"]) {
                    apartmentKeyArray = [myWingMutableDictionary allKeys];
                    for (int i = 0; i < [apartmentKeyArray count]; i++) {
                        NSMutableDictionary *myApartmentDictionary = [NSMutableDictionary new];
                        myApartmentDictionary = [myWingMutableDictionary objectForKey:[apartmentKeyArray objectAtIndex:i]];
                        
                        if (![myIsSold isEqualToString:[myApartmentDictionary objectForKey:@"IsSold"]]) {
                            [myWingMutableDictionary removeObjectForKey:[apartmentKeyArray objectAtIndex:i]];
                        }
                    }
                }
                
                [myFloorMutableDictionary setValue:myWingMutableDictionary forKey:[wingKeyArray objectAtIndex:z]];
            }
            
            [myTowerMutableDictionary setValue:myFloorMutableDictionary forKey:[floorkeyArray objectAtIndex:y]];
        }
        
        [filterMutableDictionary setValue:myTowerMutableDictionary forKeyPath:[towerKeyArray objectAtIndex:x]];
    }
    
    NSMutableArray *filterArray = [NSMutableArray new];
    
    for (NSString *myTowerKey in filterMutableDictionary) {
        NSDictionary *myTowerDictionary = [[NSDictionary alloc] initWithDictionary:[filterMutableDictionary objectForKey:myTowerKey]];
        
        for (NSString *myFloorKey in myTowerDictionary) {
            NSDictionary *myFloorDictionary = [[NSDictionary alloc] initWithDictionary:[myTowerDictionary objectForKey:myFloorKey]];
            
            for (NSString *myWingKey in myFloorDictionary) {
                NSMutableDictionary *myWingDictionary = [[NSMutableDictionary alloc] initWithDictionary:[myFloorDictionary objectForKey:myWingKey]];
                
                for (NSString *myApartmentKey in myWingDictionary) {
                    NSMutableDictionary *myApartmentDictionary = [[NSMutableDictionary alloc] initWithDictionary:[myWingDictionary objectForKey:myApartmentKey]];
                    [myApartmentDictionary setValue:myTowerKey forKey:@"Tower"];
                    [myApartmentDictionary setValue:myFloorKey forKey:@"Floor"];
                    [myApartmentDictionary setValue:myWingKey forKey:@"Wing"];
                    [myApartmentDictionary setValue:myApartmentKey forKey:@"Apartment"];
                    [myApartmentDictionary setValue:[NSString stringWithFormat:@"%@%@", myTowerKey, myApartmentKey] forKey:@"TowerApartment"];
                    
                    [filterArray addObject:myApartmentDictionary];
                }
            }
        }
    }
  
    NSSortDescriptor *sortByTowerApartment = [NSSortDescriptor sortDescriptorWithKey:@"TowerApartment"
                                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByTowerApartment];
    NSArray *sortedFilterArray = [filterArray sortedArrayUsingDescriptors:sortDescriptors];

    return sortedFilterArray;
}

- (IBAction)segueToGeneratePDF:(id)sender {
    [self performSegueWithIdentifier:@"PDFSegue" sender:self];
}

@end
