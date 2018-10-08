//
//  ApartmentDetailViewController.m
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 10/07/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import "ApartmentDetailViewController.h"
#import "ApartmentDetailViewPage1ViewController.h"
#import "ApartmentDetailViewPage3ViewController.h"
#import "PSPushPopPressView.h"
#import <MessageUI/MessageUI.h>

@interface ApartmentDetailViewController () <MFMailComposeViewControllerDelegate>

@property BOOL isLowInterestButtonPressed;
@property BOOL isMediumInterestButtonPressed;
@property BOOL isHighInterestButtonPressed;

@end

@implementation ApartmentDetailViewController
@synthesize apartmentComplexLocationImageView, apartmentLayoutImageView, droneImageViewA, droneImageViewB, lowInterestButton, mediumInterestButton, highInterestButton, infoLabel, droneImageViewALabel, droneImageViewBLabel, apartmentComplexLocationString, apartmentLayoutString, apartmentString, towerString, wingString, floorString, sqftString, isLowInterestButtonPressed, isMediumInterestButtonPressed, isHighInterestButtonPressed;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"DetailViewPage2Segue" forKey:@"apartmentDetailViewSegue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    lowInterestButton.layer.borderWidth = 0.5f;
    lowInterestButton.layer.borderColor = [UIColor redColor].CGColor;
    [lowInterestButton setBackgroundColor:[UIColor clearColor]];
    
    mediumInterestButton.layer.borderWidth = 0.5f;
    mediumInterestButton.layer.borderColor = [UIColor yellowColor].CGColor;
    [mediumInterestButton setBackgroundColor:[UIColor clearColor]];
    
    highInterestButton.layer.borderWidth = 0.5f;
    highInterestButton.layer.borderColor = [UIColor greenColor].CGColor;
    [highInterestButton setBackgroundColor:[UIColor clearColor]];
    
    isLowInterestButtonPressed = false;
    isMediumInterestButtonPressed = false;
    isHighInterestButtonPressed = false;
    
    NSMutableDictionary *apartmentInterestMutableDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"apartmentInterestMutableDictionary"] mutableCopy];
    
    if ([apartmentInterestMutableDictionary objectForKey:apartmentString] != nil) {
        if ([[apartmentInterestMutableDictionary objectForKey:apartmentString] isEqual:@"Interest Level 1"]) {
            [lowInterestButton setBackgroundColor:[UIColor redColor]];
            isLowInterestButtonPressed = true;
        }
        if ([[apartmentInterestMutableDictionary objectForKey:apartmentString] isEqual:@"Interest Level 2"]) {
            [mediumInterestButton setBackgroundColor:[UIColor yellowColor]];
            isMediumInterestButtonPressed = true;
        }
        if ([[apartmentInterestMutableDictionary objectForKey:apartmentString] isEqual:@"Interest Level 3"]) {
            [highInterestButton setBackgroundColor:[UIColor greenColor]];
            isHighInterestButtonPressed = true;
        }
    }
    
    [infoLabel setText:[NSString stringWithFormat:@"Tower %@, Floor %@, Apartment %@, %@ Layout, Project Completion: Mid 2018", towerString, floorString, wingString, apartmentLayoutString]];
    
    [apartmentComplexLocationImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", apartmentComplexLocationString]]];
    [apartmentLayoutImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", sqftString]]];
    
    NSArray *directionsArray = [[NSArray alloc] initWithArray:[self createDirectionsArray]];
    NSArray *longFormDirectionsArray = [[NSArray alloc] initWithArray:[self createLongFormDirectionsArray]];
    
    NSString *fileName = [NSString stringWithFormat:@"%@%@%@", towerString ,wingString ,floorString];
    
    int count = 0;
    int imageLabelCount = 0;
    NSMutableArray *fileNameArray = [NSMutableArray new];
    
    for (int i = 0; i < [directionsArray count]; i++) {
        NSString *pathAndFileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%@", fileName, [directionsArray objectAtIndex:i]] ofType:@"jpg"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:pathAndFileName]) {
            imageLabelCount++;
            count++;
            [fileNameArray addObject:[NSString stringWithFormat:@"%@%@", fileName, [directionsArray objectAtIndex:i]]];
            if (imageLabelCount == 1) {
                [droneImageViewALabel setText:[longFormDirectionsArray objectAtIndex:i]];
                [droneImageViewBLabel setText:[longFormDirectionsArray objectAtIndex:i]];
            }
            if (imageLabelCount == 2) {
                [droneImageViewBLabel setText:[longFormDirectionsArray objectAtIndex:i]];
            }
        }
    }
    
    // create the push pop press container
    PSPushPopPressView *pushPopPressView1 = [[PSPushPopPressView alloc] initWithFrame:CGRectMake(129, 325, 267, 197)];
    pushPopPressView1.pushPopPressViewDelegate = self;
    [self.view addSubview:pushPopPressView1];
    
    PSPushPopPressView *pushPopPressView2 = [[PSPushPopPressView alloc] initWithFrame:CGRectMake(129, 546, 267, 197)];
    pushPopPressView2.pushPopPressViewDelegate = self;
    [self.view addSubview:pushPopPressView2];
    
    PSPushPopPressView *pushPopPressView3 = [[PSPushPopPressView alloc] initWithFrame:CGRectMake(484, 193, 540, 512)];
    pushPopPressView3.pushPopPressViewDelegate = self;
    [self.view addSubview:pushPopPressView3];
    
    PSPushPopPressView *pushPopPressView4 = [[PSPushPopPressView alloc] initWithFrame:CGRectMake(-13, 56, 525, 261)];
    pushPopPressView4.pushPopPressViewDelegate = self;
    [self.view addSubview:pushPopPressView4];
    
    [droneImageViewA setContentMode:UIViewContentModeScaleAspectFit];
    [droneImageViewB setContentMode:UIViewContentModeScaleAspectFit];
    [apartmentLayoutImageView setContentMode:UIViewContentModeScaleAspectFit];
    [apartmentComplexLocationImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    if (count == 2) {
        [droneImageViewA setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", [fileNameArray objectAtIndex:0]]]];
        [droneImageViewB setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", [fileNameArray objectAtIndex:1]]]];
    } else {
        [droneImageViewA setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", [fileNameArray objectAtIndex:0]]]];
        [droneImageViewB removeFromSuperview];
        [droneImageViewBLabel removeFromSuperview];
        [pushPopPressView2 removeFromSuperview];
    }
    
    droneImageViewA.frame = pushPopPressView1.bounds;
    droneImageViewA.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    droneImageViewA.clipsToBounds = YES;
    [pushPopPressView1 addSubview:droneImageViewA];
    
    droneImageViewB.frame = pushPopPressView2.bounds;
    droneImageViewB.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    droneImageViewB.clipsToBounds = YES;
    [pushPopPressView2 addSubview:droneImageViewB];
    
    apartmentLayoutImageView.frame = pushPopPressView3.bounds;
    apartmentLayoutImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    apartmentLayoutImageView.clipsToBounds = YES;
    [pushPopPressView3 addSubview:apartmentLayoutImageView];
    
    apartmentComplexLocationImageView.frame = pushPopPressView4.bounds;
    apartmentComplexLocationImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    apartmentComplexLocationImageView.clipsToBounds = YES;
    [pushPopPressView4 addSubview:apartmentComplexLocationImageView];
}

- (NSArray *) createDirectionsArray {
    NSArray *directionsArray = @[@"N", @"NE", @"NW", @"E", @"S", @"SE", @"SW", @"W"];
    return directionsArray;
}

- (NSArray *) createLongFormDirectionsArray {
    NSArray *longFormDirectionsArray = @[@"North", @"North East", @"North West", @"East", @"South", @"South East", @"South West", @"West"];
    return longFormDirectionsArray;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"page1Segue"]) {
        ApartmentDetailViewPage1ViewController *myApartmentDetailViewPage1ViewController = (ApartmentDetailViewPage1ViewController *) segue.destinationViewController;
        
        myApartmentDetailViewPage1ViewController.apartmentComplexLocationString = apartmentComplexLocationString;
        myApartmentDetailViewPage1ViewController.apartmentLayoutString = apartmentLayoutString;
        myApartmentDetailViewPage1ViewController.apartmentString = apartmentString;
        myApartmentDetailViewPage1ViewController.towerString = towerString;
        myApartmentDetailViewPage1ViewController.wingString = wingString;
        myApartmentDetailViewPage1ViewController.floorString = floorString;
        myApartmentDetailViewPage1ViewController.sqftString = sqftString;
    }
    if ([segue.identifier isEqualToString:@"page3Segue"]) {
        ApartmentDetailViewPage3ViewController *myApartmentDetailViewPage3ViewController = (ApartmentDetailViewPage3ViewController *) segue.destinationViewController;
        
        myApartmentDetailViewPage3ViewController.apartmentComplexLocationString = apartmentComplexLocationString;
        myApartmentDetailViewPage3ViewController.apartmentLayoutString = apartmentLayoutString;
        myApartmentDetailViewPage3ViewController.apartmentString = apartmentString;
        myApartmentDetailViewPage3ViewController.towerString = towerString;
        myApartmentDetailViewPage3ViewController.wingString = wingString;
        myApartmentDetailViewPage3ViewController.floorString = floorString;
        myApartmentDetailViewPage3ViewController.sqftString = sqftString;
    }
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
        case MFMailComposeResultFailed: {
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Failed to send email" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            break;
        }
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)homeButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)lowInterestButtonPressed:(id)sender {
    if (!isLowInterestButtonPressed) {
        [lowInterestButton setBackgroundColor:[UIColor redColor]];
        [mediumInterestButton setBackgroundColor:[UIColor clearColor]];
        [highInterestButton setBackgroundColor:[UIColor clearColor]];
        
        isLowInterestButtonPressed = true;
        isMediumInterestButtonPressed = false;
        isHighInterestButtonPressed = false;
        
        NSMutableDictionary *apartmentInterestMutableDictionary;
        apartmentInterestMutableDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"apartmentInterestMutableDictionary"] mutableCopy];
        
        if (apartmentInterestMutableDictionary == nil) {
            apartmentInterestMutableDictionary = [[NSMutableDictionary alloc] init];
        }
        
        [apartmentInterestMutableDictionary setObject:@"Interest Level 1" forKey:apartmentString];
        [[NSUserDefaults standardUserDefaults] setObject:apartmentInterestMutableDictionary forKey:@"apartmentInterestMutableDictionary"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        [lowInterestButton setBackgroundColor:[UIColor clearColor]];
        isLowInterestButtonPressed = false;
    }
}

- (IBAction)mediumInterestButtonPressed:(id)sender {
    if (!isMediumInterestButtonPressed) {
        [mediumInterestButton setBackgroundColor:[UIColor yellowColor]];
        [lowInterestButton setBackgroundColor:[UIColor clearColor]];
        [highInterestButton setBackgroundColor:[UIColor clearColor]];
        
        isMediumInterestButtonPressed = true;
        isLowInterestButtonPressed = false;
        isHighInterestButtonPressed = false;
        
        NSMutableDictionary *apartmentInterestMutableDictionary;
        apartmentInterestMutableDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"apartmentInterestMutableDictionary"] mutableCopy];
        
        if (apartmentInterestMutableDictionary == nil) {
            apartmentInterestMutableDictionary = [[NSMutableDictionary alloc] init];
        }
        
        [apartmentInterestMutableDictionary setObject:@"Interest Level 2" forKey:apartmentString];
        [[NSUserDefaults standardUserDefaults] setObject:apartmentInterestMutableDictionary forKey:@"apartmentInterestMutableDictionary"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [mediumInterestButton setBackgroundColor:[UIColor clearColor]];
        isMediumInterestButtonPressed = false;
    }
}

- (IBAction)highInterestButtonPressed:(id)sender {
    if (!isHighInterestButtonPressed) {
        [highInterestButton setBackgroundColor:[UIColor greenColor]];
        [lowInterestButton setBackgroundColor:[UIColor clearColor]];
        [mediumInterestButton setBackgroundColor:[UIColor clearColor]];
        
        isHighInterestButtonPressed = true;
        isLowInterestButtonPressed = false;
        isMediumInterestButtonPressed = false;
        
        NSMutableDictionary *apartmentInterestMutableDictionary;
        apartmentInterestMutableDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"apartmentInterestMutableDictionary"] mutableCopy];
        
        if (apartmentInterestMutableDictionary == nil) {
            apartmentInterestMutableDictionary = [[NSMutableDictionary alloc] init];
        }
        
        [apartmentInterestMutableDictionary setObject:@"Interest Level 3" forKey:apartmentString];
        [[NSUserDefaults standardUserDefaults] setObject:apartmentInterestMutableDictionary forKey:@"apartmentInterestMutableDictionary"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [highInterestButton setBackgroundColor:[UIColor clearColor]];
        isHighInterestButtonPressed = false;
    }
}

- (IBAction)emailCustomerButtonPressed:(id)sender {
    // Email Content
    NSString *projectOverviewString = @"Orchid Whitefield is an oasis to itself. It’s 7 acre sprawling campus is designed by world renowned landscape architects who have ensured that 85% of the total campus area is landscaped. The campus is equipped with everything that new age living can ask for. A sports complex with various games, to a swimming pool, to gardens, to senior citizen enclaves, from kids play areas to vehicle safe roads, the campus is an experience in active living for all age groups.";
    NSString *amenitiesString = @"Amenities:Sports Arena, Swimming Pool, Landscaping, Clubhouse, Gym, Tennis, Basketball, Cricket Pitch, Football, Library, Steam Room, Children’s Play Area";
    NSString *ecoFriendlyFeaturesString = @"Eco-friendly Features: Rainwater Harvesting, Water Recycling, Waste Segregation";
    NSString *accessibilityAndKeyDistancesString = @"Accessibility and Key Distances: Location – Off Whitefield Main Road, Behind Forum Value Mall, Bengaluru, Distance from MG Road – 18.1 Kms, Distance from Railway Station – 23.7 Kms, Distance from Airport – 51 Kms, Nearest Metro station – 16.9 Kms, Nearest Ring Road – 17.8 Kms";
    
    NSString *projectSpecificationsTitleString = @"Project Specifications";
    NSString *wallFinishingString = @"Wall Finishing: Internal walls and ceiling finished with oil bound distemper | External walls painted with weather coat / weather shield paint";
    NSString *flooringString = @"Flooring: Vitrified tiles for the complete flat | Ceramic tiles for balconies and utility areas | Lobbies with rustic / vitrified tiles | Staircase with polished Kota stone / granite";
    NSString *doorsAndWindowsString = @"Doors & Windows: Main doors with teak wood frames and teak finish flush doors | Other doors with Sal wood frames with moulded panel doors | Powder coated Aluminium / UPVC windows";
    NSString *kitchenString = @"Kitchen: Granite counter top with single drain board sink: Cladding with ceramic tiles 2′ above the kitchen platform";
    NSString *toiletsString = @"Toilets: Ceramic tiles dado upto 7′ height | Grid false ceiling | CP Fittings – Jaguar or equivalent | EWC and ceramic basins of Cera or equivalent";
    NSString *electricalString = @"Electrical: 1 BHK / 2 BHK Nano : 3 KW KPTCL supply and 0.75 KW DG back-up | 2 BHK : 4 KW KPTCL supply & 0.75 KW DG back-up | 3 BHK : 5 KW KPTCL supply & 1 KW DG back-up | 100% DG backup for pumps, lifts and common areas";
    NSString *waterSupplyString = @"Water Supply: CPVC line for water supply | UPVC / PVC lines for soil, drainage, and external lines | Sewage treatment plant | Rain water harvesting system";
    NSString *liftsString = @"Lifts: One 8 passenger lift and a second 13 passenger lift";
    
    NSString *compliancesString = @"Compliances: Water, Land, Electricity";
    
    NSString *messageBody = [NSString stringWithFormat:@"%@\n\n\n%@\n%@\n%@\n\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n\n%@", projectOverviewString, amenitiesString, ecoFriendlyFeaturesString, accessibilityAndKeyDistancesString, projectSpecificationsTitleString, wallFinishingString, flooringString, doorsAndWindowsString, kitchenString, toiletsString, electricalString, waterSupplyString, liftsString, compliancesString];
    // Email Subject
    NSString *emailTitle = [NSString stringWithFormat:@"Apartment %@%@%@ Information - Orchid Whitefield", towerString, floorString, wingString];
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *emailDialog = [[MFMailComposeViewController alloc] init];
        [emailDialog setMailComposeDelegate:self];
        [emailDialog setSubject:emailTitle];
        [emailDialog setMessageBody:messageBody isHTML:NO];
        
        UIImage *image = [UIImage imageNamed:@"Orchid Whitefield.png"];
        NSData *emailAttachment = UIImageJPEGRepresentation(image ,1.0);
        [emailDialog addAttachmentData:emailAttachment mimeType:@"image/png" fileName:@"Orchid Whitefield.png"];
        
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", apartmentComplexLocationString]];
        emailAttachment = UIImageJPEGRepresentation(image ,1.0);
        [emailDialog addAttachmentData:emailAttachment mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@.png", apartmentComplexLocationString]];
        
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", sqftString]];
        emailAttachment = UIImageJPEGRepresentation(image ,1.0);
        [emailDialog addAttachmentData:emailAttachment mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@.png", sqftString]];
        
        NSArray *directionsArray = [[NSArray alloc] initWithArray:[self createDirectionsArray]];
        int count = 0;
        NSString *fileName = [NSString stringWithFormat:@"%@%@%@", towerString ,wingString ,floorString];
        NSMutableArray *fileNameArray = [NSMutableArray new];
        
        for (int i = 0; i < [directionsArray count]; i++) {
            NSString *pathAndFileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%@", fileName, [directionsArray objectAtIndex:i]] ofType:@"jpg"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:pathAndFileName]) {
                count++;
                [fileNameArray addObject:[NSString stringWithFormat:@"%@%@", fileName, [directionsArray objectAtIndex:i]]];
            }
        }
        
        if (count == 2) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", [fileNameArray objectAtIndex:0]]];
            emailAttachment = UIImageJPEGRepresentation(image ,1.0);
            [emailDialog addAttachmentData:emailAttachment mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@.jpg", [fileNameArray objectAtIndex:0]]];
            
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", [fileNameArray objectAtIndex:1]]];
            emailAttachment = UIImageJPEGRepresentation(image ,1.0);
            [emailDialog addAttachmentData:emailAttachment mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@.jpg", [fileNameArray objectAtIndex:1]]];
        } else {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", [fileNameArray objectAtIndex:0]]];
            emailAttachment = UIImageJPEGRepresentation(image ,1.0);
            [emailDialog addAttachmentData:emailAttachment mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@.jpg", [fileNameArray objectAtIndex:0]]];
        }
        
        [self.navigationController presentViewController:emailDialog animated:YES completion:nil];
    } else {
        NSLog(@"Mail not Working!!");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please check whether your email account has been configured with this device." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)page1ButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"page1Segue" sender:self];
}

- (IBAction)page3ButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"page3Segue" sender:self];
}

@end
