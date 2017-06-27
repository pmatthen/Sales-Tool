//
//  AppDelegate.h
//  Goyal & Co Sales App
//
//  Created by Poulose Matthen on 27/06/17.
//  Copyright © 2017 Poulose Matthen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

