//
//  DHViewController.m
//  iBcryptPwdHash
//
//  Created by Daniel Hjort on 5/2/14.
//  Copyright (c) 2014 Daniel Hjort. All rights reserved.
//

#import "DHViewController.h"
#import "JFBCrypt.h"
#import "DHPwdHashUtil.h"

@interface DHViewController ()

@end

@implementation DHViewController {
    BOOL mRoundsAreVisible, mBookmarksAreVisible;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.roundsPickerHandler = [[DHRoundsPickerHandler alloc] initWithDelegate:self];
    self.roundsPicker.dataSource = self.roundsPickerHandler;
    self.roundsPicker.delegate = self.roundsPickerHandler;
    [self.roundsPicker selectRow:self.roundsPickerHandler.defaultRow inComponent:0 animated:NO];
    [self.saltField setText:[self.roundsPickerHandler getCurrentSalt]];
    
    self.bookmarksPickerHandler = [[DHBookmarksPickerHandler alloc] initWithPicker:self.bookmarksPicker AndDelegate:self];
    self.bookmarksPicker.dataSource = self.bookmarksPickerHandler;
    self.bookmarksPicker.delegate = self.bookmarksPickerHandler;
    
    [self.bottomConstraintCopyright setConstant:13];
    [self.bottomConstraintBookmarks setConstant:0];
    [self.bottomConstraintRounds setConstant:0];
    mRoundsAreVisible = NO;
    mBookmarksAreVisible = NO;
    
    CGRect toolBarFrame = [self.toolBar frame];
    toolBarFrame.origin.y = 20;
    [self.toolBar setFrame:toolBarFrame];
    
    [self.hashedPasswordLabel setText:@""];
    self.passwordField.delegate = self;
    
    [self.addressField setText:@"http://www.example.com"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Helpers

- (void)copyToPasteboard:(NSString*)text
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = text;
}

- (void)allTextFieldResign
{
    [self.addressField resignFirstResponder];
    [self.saltField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

- (void)inputEnabled:(BOOL)enabled
{
    [self.addressField setUserInteractionEnabled:enabled];
    [self.saltField setUserInteractionEnabled:enabled];
    [self.passwordField setUserInteractionEnabled:enabled];
    [self.createButton setUserInteractionEnabled:enabled];
    
    if (!enabled) {
        [self allTextFieldResign];
    }
}

- (void)create
{
    [self.infoLabel setText:@"Please wait."];
    [self inputEnabled:NO];

    // check salt
    NSString* salt = [self.saltField text];
    if (salt.length == 0) {
        salt = [JFBCrypt generateSaltWithNumberOfRounds:self.roundsPickerHandler.selectedRounds];
        [self.saltField setText:salt];
        [self.roundsPickerHandler saveSalt:salt ForRounds:self.roundsPickerHandler.selectedRounds];
        // save salt
    } else if (![salt hasPrefix:@"$2a$"]) {
        // invalid salt
        [self inputEnabled:YES];
        [self.infoLabel setText:@"Salt not valid. Remove to generate new one."];
        return;
    }
    
    NSString* address = [self.addressField text];
    NSString* domain = [DHPwdHashUtil extractDomain:address];
    if (domain.length == 0) {
        // no entered password
        [self inputEnabled:YES];
        [self.infoLabel setText:@"Please enter a site address."];
        return;
    }
    [self.bookmarksPickerHandler saveBookmark:address];
    
    NSString* password = [self.passwordField text];
    if (password.length == 0) {
        // no entered password
        [self inputEnabled:YES];
        [self.infoLabel setText:@"Please enter a password to hash."];
        return;
    }
    
    NSString* toBeHashed = [domain stringByAppendingString:password];
    
    /* do the rest asyncronously */
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // do the hashing
        NSString* hash = [JFBCrypt hashPassword:toBeHashed withSalt:salt];
        NSString* result = [DHPwdHashUtil removeSalt:salt FromHash:hash];
        result = [DHPwdHashUtil applySize:password.length + 2 AndAlphaNumerical:[DHPwdHashUtil isAlphaNumeric:password] ToPassword:result];
        
        // copy to clipboard
        [self.infoLabel setText:@"Password copied to clipboard."];
        [self copyToPasteboard:result];
        [self.hashedPasswordLabel setText:result];
        
        [self inputEnabled:YES];
    });
}

#pragma mark - Animations

- (void)hideRounds {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.bottomConstraintRounds.constant = 0;
                         [self.view layoutIfNeeded];
                     }];
    mRoundsAreVisible = FALSE;
}

- (void)showRounds {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.bottomConstraintRounds.constant = 162;
                         [self.view layoutIfNeeded];
                     }];
    mRoundsAreVisible = TRUE;
}

- (void)hideBookmarks {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.bottomConstraintBookmarks.constant = 0;
                         [self.view layoutIfNeeded];
                     }];
    mBookmarksAreVisible = FALSE;
}

- (void)showBookmarks {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.bottomConstraintBookmarks.constant = 162;
                         [self.view layoutIfNeeded];
                     }];
    mBookmarksAreVisible = TRUE;
}

#pragma mark - Actions

- (IBAction)createAction:(id)sender
{
    NSLog(@"createAction");
    
    [self create];
}

- (IBAction)roundsAction:(id)sender
{
    NSLog(@"settingsAction");
    // show/hide rounds pop-over/spinner
    [self allTextFieldResign];
    if (mRoundsAreVisible) {
        [self hideRounds];
    } else {
        if (mBookmarksAreVisible) {
            [self hideBookmarks];
        }
        [self showRounds];
    }
}

- (IBAction)bookmarksAction:(id)sender
{
    NSLog(@"bookmarksAction");
    // show/hide bookmarks pop-over/spinner
    [self allTextFieldResign];
    if (mBookmarksAreVisible) {
        [self hideBookmarks];
    } else {
        if (mRoundsAreVisible) {
            [self hideRounds];
        }
        [self showBookmarks];
    }
}

#pragma mark - Notifications

- (void)keyboardWillShow:(NSNotification *)notification
{
    [self hideBookmarks];
    [self hideRounds];
}

#pragma mark - DHBookmarkPickerDelegate

- (void)selectedBookmark:(NSString*)bookmark
{
    [self.addressField setText:bookmark];
}

#pragma mark - DHRoundsPickerDelegate

- (void)selectedRounds:(int)rounds WithSalt:(NSString*)salt
{
    [self.saltField setText:salt];
}

#pragma mark - UITextfieldDelegate

- (BOOL) textFieldShouldClear:(UITextField *)textField{
    [self.infoLabel setText:@"Password erased from clipboard."];
    [self copyToPasteboard:@""];
    [self.hashedPasswordLabel setText:@""];
    return YES;
}

@end
