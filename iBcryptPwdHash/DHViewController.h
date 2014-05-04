//
//  DHViewController.h
//  iBcryptPwdHash
//
//  Created by Daniel Hjort on 5/2/14.
//  Copyright (c) 2014 Daniel Hjort. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHViewController : UIViewController

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (strong, nonatomic) IBOutlet UILabel* infoLabel;
@property (strong, nonatomic) IBOutlet UILabel* hashedPasswordLabel;

@property (strong, nonatomic) IBOutlet UITextField* addressField;
@property (strong, nonatomic) IBOutlet UITextField* saltField;
@property (strong, nonatomic) IBOutlet UITextField* passwordField;
@property (strong, nonatomic) IBOutlet UIButton* createButton;

- (IBAction)createAction:(id)sender;
- (IBAction)settingsAction:(id)sender;
- (IBAction)bookmarksAction:(id)sender;

@end
