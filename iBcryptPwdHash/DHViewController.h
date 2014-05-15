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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintCopyright;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintBookmarks;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintRounds;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraintInputIpad;

@property (weak, nonatomic) IBOutlet UIView* tapView;
@property (weak, nonatomic) IBOutlet UIToolbar* toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* bookmarksButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* roundsButton;

@property (weak, nonatomic) IBOutlet UILabel* infoLabel;
@property (weak, nonatomic) IBOutlet UILabel* hashedPasswordLabel;
@property (weak, nonatomic) IBOutlet UILabel* copyrightLabel;

@property (weak, nonatomic) IBOutlet UITextField* addressField;
@property (weak, nonatomic) IBOutlet UITextField* saltField;
@property (weak, nonatomic) IBOutlet UITextField* passwordField;
@property (weak, nonatomic) IBOutlet UIButton* createButton;

@property (weak, nonatomic) IBOutlet UIPickerView* bookmarksPicker;
@property (weak, nonatomic) IBOutlet UIPickerView* roundsPicker;

@property (strong, nonatomic) UIGestureRecognizer* tapGestureRecognizer;

- (IBAction)createAction:(id)sender;
- (IBAction)roundsAction:(id)sender;
- (IBAction)bookmarksAction:(id)sender;

@end
