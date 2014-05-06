//
//  DHViewController.h
//  iBcryptPwdHash
//
//  Created by Daniel Hjort on 5/2/14.
//  Copyright (c) 2014 Daniel Hjort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHRoundsPickerHandler.h"
#import "DHRoundsPickerDelegate.h"
#import "DHBookmarksPickerHandler.h"
#import "DHBookmarksPickerDelegate.h"
#import "DHPickerViewController.h"

@interface DHViewController : UIViewController <DHBookmarksPickerDelegate, DHRoundsPickerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) DHRoundsPickerHandler* roundsPickerHandler;
@property (strong, nonatomic) DHBookmarksPickerHandler* bookmarksPickerHandler;

@property (strong, nonatomic) DHPickerViewController* roundsPickerController;
@property (strong, nonatomic) UIPopoverController* roundsPopoverController;

@property (strong, nonatomic) DHPickerViewController* bookmarksPickerController;
@property (strong, nonatomic) UIPopoverController* bookmarksPopoverController;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintCopyright;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintBookmarks;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintRounds;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topConstraintInputIpad;

@property (strong, nonatomic) IBOutlet UIToolbar* toolBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem* bookmarksButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem* roundsButton;

@property (strong, nonatomic) IBOutlet UILabel* infoLabel;
@property (strong, nonatomic) IBOutlet UILabel* hashedPasswordLabel;

@property (strong, nonatomic) IBOutlet UITextField* addressField;
@property (strong, nonatomic) IBOutlet UITextField* saltField;
@property (strong, nonatomic) IBOutlet UITextField* passwordField;
@property (strong, nonatomic) IBOutlet UIButton* createButton;

@property (strong, nonatomic) IBOutlet UIPickerView* bookmarksPicker;
@property (strong, nonatomic) IBOutlet UIPickerView* roundsPicker;

- (IBAction)createAction:(id)sender;
- (IBAction)roundsAction:(id)sender;
- (IBAction)bookmarksAction:(id)sender;

@end
