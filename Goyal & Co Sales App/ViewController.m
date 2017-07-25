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
#import "PDFViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController (Private) <UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>

- (void) generatePdfWithFilePath: (NSString *)thefilePath;
- (void) drawPageNumber:(NSInteger)pageNum;
- (void) drawBorder;
- (void) drawText;
- (void) drawLine;
- (void) drawHeader;
- (void) drawImage;

@end

@implementation ViewController
@synthesize myCSVArray, towerPicker, floorPicker, wingPicker, layoutPicker, sideFacingPicker, soldPicker, myTableView, recordsLabel, towerArray, floorArray, wingArray, layoutArray, directionArray, isSoldArray, myFilterArray, myMasterDictionary, apartmentDetailsDictionary, apartmentInterestMutableDictionary, userDictionary, keyArray;

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
    
    userDictionary = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"userDictionary"]];
    apartmentInterestMutableDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"apartmentInterestMutableDictionary"] mutableCopy];
    
    keyArray = [[NSMutableArray alloc] initWithArray:[apartmentInterestMutableDictionary allKeys]];
    [keyArray sortUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        return [str1 compare:str2 options:(NSNumericSearch)];
    }];
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

- (void) drawBorder {
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    UIColor *borderColor = [UIColor brownColor];
    
    CGRect rectFrame = CGRectMake(kBorderInset, kBorderInset, pageSize.width-kBorderInset*2, pageSize.height-kBorderInset*2);
    
    CGContextSetStrokeColorWithColor(currentContext, borderColor.CGColor);
    CGContextSetLineWidth(currentContext, kBorderWidth);
    CGContextStrokeRect(currentContext, rectFrame);
}

- (void)drawPageNumber:(NSInteger)pageNumber {
    NSString* pageNumberString = [NSString stringWithFormat:@"Page %d", pageNumber];
    UIFont* theFont = [UIFont systemFontOfSize:12];
    
    CGSize pageNumberStringSize = [pageNumberString sizeWithFont:theFont
                                               constrainedToSize:pageSize
                                                   lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect stringRenderingRect = CGRectMake(kBorderInset,
                                            pageSize.height - 40.0,
                                            pageSize.width - 2*kBorderInset,
                                            pageNumberStringSize.height);
    
    [pageNumberString drawInRect:stringRenderingRect withFont:theFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
}

- (void) drawHeader {
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(currentContext, 0.3, 0.7, 0.2, 1.0);
    
    NSString *textToDraw = @"NEW NEW Customer Details";
    
    UIFont *font = [UIFont systemFontOfSize:24.0];
    
    CGSize stringSize = [textToDraw sizeWithFont:font constrainedToSize:CGSizeMake(pageSize.width - 2*kBorderInset-2*kMarginInset, pageSize.height - 2*kBorderInset - 2*kMarginInset) lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect renderingRect = CGRectMake(kBorderInset + kMarginInset, kBorderInset + kMarginInset, pageSize.width - 2*kBorderInset - 2*kMarginInset, stringSize.height);
    
    [textToDraw drawInRect:renderingRect withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
}

- (void) drawText {
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(currentContext, 0.0, 0.0, 0.0, 1.0);
    
    NSString *textToDraw = [NSString stringWithFormat:@"Name: %@\nEmail: %@\nPhone: %@\n\n\n", [userDictionary objectForKey:@"name"], [userDictionary objectForKey:@"email"], [userDictionary objectForKey:@"phone"]];
    
    for (int i = 0; i < [keyArray count]; i++) {
        textToDraw = [NSString stringWithFormat:@"%@\n%@: %@", textToDraw, [keyArray objectAtIndex:i], [apartmentInterestMutableDictionary objectForKey:[keyArray objectAtIndex:i]]];
    }
    
    UIFont *font = [UIFont systemFontOfSize:14.0];
    
    CGSize stringSize = [textToDraw sizeWithFont:font
                               constrainedToSize:CGSizeMake(pageSize.width - 2*kBorderInset-2*kMarginInset, pageSize.height - 2*kBorderInset - 2*kMarginInset)
                                   lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect renderingRect = CGRectMake(kBorderInset + kMarginInset, kBorderInset + kMarginInset + 50.0, pageSize.width - 2*kBorderInset - 2*kMarginInset, stringSize.height);
    
    [textToDraw drawInRect:renderingRect
                  withFont:font
             lineBreakMode:UILineBreakModeWordWrap
                 alignment:UITextAlignmentLeft];
    
}

- (void) drawLine {
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(currentContext, kLineWidth);
    
    CGContextSetStrokeColorWithColor(currentContext, [UIColor blueColor].CGColor);
    
    CGPoint startPoint = CGPointMake(kMarginInset + kBorderInset, kMarginInset + kBorderInset + 40.0);
    CGPoint endPoint = CGPointMake(pageSize.width - 2*kMarginInset -2*kBorderInset, kMarginInset + kBorderInset + 40.0);
    
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(currentContext, endPoint.x, endPoint.y);
    
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
}

- (void) drawImage {
    UIImage * demoImage = [UIImage imageNamed:@"B01.png"];
    [demoImage drawInRect:CGRectMake( (pageSize.width - demoImage.size.width/2)/2, 350, demoImage.size.width/2, demoImage.size.height/2)];
}

- (void) generatePdfWithFilePath: (NSString *)thefilePath {
    UIGraphicsBeginPDFContextToFile(thefilePath, CGRectZero, nil);
    
    NSInteger currentPage = 0;
    BOOL done = NO;
    do {
        //Start a new page.
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
        
        //Draw a page number at the bottom of each page.
        currentPage++;
        [self drawPageNumber:currentPage];
        
        //Draw a border for each page.
        [self drawBorder];
        
        //Draw text for our header.
        [self drawHeader];
        
        //Draw a line below the header.
        [self drawLine];
        
        //Draw some text for the page.
        [self drawText];
        
        //        //Draw an image
        //        [self drawImage];
        done = YES;
    } while (!done);
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)segueToGeneratePDF:(id)sender {
    pageSize = CGSizeMake(612, 792);
    NSString *fileName = @"Demo.pdf";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfFileName = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    [self generatePdfWithFilePath:pdfFileName];
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *emailDialog = [[MFMailComposeViewController alloc] init];
        [emailDialog setMailComposeDelegate:self];
        NSMutableData *myPdfData = [NSMutableData dataWithContentsOfFile:pdfFileName];
        [emailDialog addAttachmentData:myPdfData mimeType:@"application/pdf" fileName:@"Demo"];
        [self.navigationController presentViewController:emailDialog animated:YES completion:nil];
    } else {
        NSLog(@"Mail not Working!!");
    }
    
}

- (IBAction)segueToCustomerDetails:(id)sender {
    [self performSegueWithIdentifier:@"CustomerDetailSegue" sender:self];
}

- (IBAction)resetButtonPressed:(id)sender {
    NSLog(@"Ask user to confirm");
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *myDictionary = [userDefaults dictionaryRepresentation];
    for (id key in myDictionary) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}

@end
