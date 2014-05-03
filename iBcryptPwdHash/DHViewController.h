//
//  DHViewController.h
//  iBcryptPwdHash
//
//  Created by Daniel Hjort on 5/2/14.
//  Copyright (c) 2014 Daniel Hjort. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHViewController : UIViewController

@property IBOutlet UILabel* infoLabel;
@property IBOutlet UILabel* hashedPasswordLabel;

@property IBOutlet UITextField* addressField;
@property IBOutlet UITextField* saltField;
@property IBOutlet UITextField* passwordField;

@end
