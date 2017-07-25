//
//  PDFViewController.h
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 11/07/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBorderInset            20.0
#define kBorderWidth            1.0
#define kMarginInset            10.0

//Line drawing
#define kLineWidth              1.0

@interface PdfGenerationDemoViewController : UIViewController {
    CGSize pageSize;
}

@property NSMutableDictionary *apartmentInterestMutableDictionary;
@property NSMutableDictionary *userDictionary;
@property NSMutableArray *keyArray;

- (IBAction)generatePdfButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;

@end
