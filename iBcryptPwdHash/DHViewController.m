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

@implementation DHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.bottomConstraintCopyright setConstant:13];
    [self.bottomConstraintBookmarks setConstant:0];
    [self.bottomConstraintRounds setConstant:0];
    
    CGRect toolBarFrame = [self.toolBar frame];
    toolBarFrame.origin.y = 20;
    [self.toolBar setFrame:toolBarFrame];
    
    [self.hashedPasswordLabel setText:@""];
    
    // Get saved salt
    [self.saltField setText:@"$2a$12$ZG78Pek0VOJ8SRf./2xB5O"];
    
    // Get last address
    [self.addressField setText:@"http://www.example.com"];
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

- (void)inputEnabled:(BOOL)enabled
{
    [self.addressField setUserInteractionEnabled:enabled];
    [self.saltField setUserInteractionEnabled:enabled];
    [self.passwordField setUserInteractionEnabled:enabled];
    [self.createButton setUserInteractionEnabled:enabled];
    
    if (!enabled) {
        [self.addressField resignFirstResponder];
        [self.saltField resignFirstResponder];
        [self.passwordField resignFirstResponder];
    }
}

- (void)create
{
    [self.infoLabel setText:@"Please wait."];
    [self inputEnabled:NO];

    // check salt
    NSString* salt = [self.saltField text];
    if (salt.length == 0) {
        salt = [JFBCrypt generateSaltWithNumberOfRounds:12];
        [self.saltField setText:salt];
        // save salt
    } else if (![salt hasPrefix:@"$2a$"]) {
        // invalid salt
        [self inputEnabled:YES];
        [self.infoLabel setText:@"Salt not valid. Remove to generate new one."];
        return;
    }
    
    NSString* address = [self.addressField text];
    // save address to bookmarks
    NSString* domain = [DHPwdHashUtil extractDomain:address];
    
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
        [self.infoLabel setText:@"Password copied to paste board."];
        [self copyToPasteboard:result];
        [self.hashedPasswordLabel setText:result];
        
        [self inputEnabled:YES];
    });
}

#pragma mark - Actions

- (IBAction)createAction:(id)sender
{
    NSLog(@"createAction");
    
    [self create];
}

- (IBAction)settingsAction:(id)sender
{
    NSLog(@"settingsAction");
    // show/hide rounds pop-over/spinner
}

- (IBAction)bookmarksAction:(id)sender
{
    NSLog(@"bookmarksAction");
    // show/hide bookmarks pop-over/spinner
}

@end
