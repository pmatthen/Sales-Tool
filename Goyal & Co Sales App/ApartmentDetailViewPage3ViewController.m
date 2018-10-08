//
//  ApartmentDetailViewPage3ViewController.m
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 21/09/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import "ApartmentDetailViewPage3ViewController.h"
#import "ApartmentDetailViewController.h"
#import <MessageUI/MessageUI.h>

@interface ApartmentDetailViewPage3ViewController () <MFMailComposeViewControllerDelegate>

@property BOOL isLowInterestButtonPressed;
@property BOOL isMediumInterestButtonPressed;
@property BOOL isHighInterestButtonPressed;

@end

@implementation ApartmentDetailViewPage3ViewController
@synthesize apartmentComplexLocationString, apartmentLayoutString, apartmentString, towerString, wingString, floorString, sqftString, lowInterestButton, mediumInterestButton, highInterestButton, myScrollView, isLowInterestButtonPressed, isMediumInterestButtonPressed, isHighInterestButtonPressed;

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    myScrollView.delegate = self;
    myScrollView.scrollEnabled = YES;
    myScrollView.contentSize = CGSizeMake(1024,1209);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSUserDefaults standardUserDefaults] setObject:@"DetailViewPage3Segue" forKey:@"apartmentDetailViewSegue"];
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
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"page2Segue"]) {
        ApartmentDetailViewController *myApartmentDetailViewController = (ApartmentDetailViewController *) segue.destinationViewController;
        
        myApartmentDetailViewController.apartmentComplexLocationString = apartmentComplexLocationString;
        myApartmentDetailViewController.apartmentLayoutString = apartmentLayoutString;
        myApartmentDetailViewController.apartmentString = apartmentString;
        myApartmentDetailViewController.towerString = towerString;
        myApartmentDetailViewController.wingString = wingString;
        myApartmentDetailViewController.floorString = floorString;
        myApartmentDetailViewController.sqftString = sqftString;
    }
}

- (IBAction)homeButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)page2ButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"page2Segue" sender:self];
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

- (NSArray *) createDirectionsArray {
    NSArray *directionsArray = @[@"N", @"NE", @"NW", @"E", @"S", @"SE", @"SW", @"W"];
    return directionsArray;
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

@end
