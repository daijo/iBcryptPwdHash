//
//  DHRoundsPickerController.m
//  iBcryptPwdHash
//
//  Created by Daniel Hjort on 5/4/14.
//  Copyright (c) 2014 Daniel Hjort. All rights reserved.
//

#import "DHRoundsPickerHandler.h"
#import "DHRoundsPickerDelegate.h"

@implementation DHRoundsPickerHandler

- (id)init
{
    self = [super init];
    if (self) {
        
        self.roundNames = @[@"4 Rounds", @"6 Rounds", @"8 Rounds", @"10 Rounds", @"12 Rounds", @"14 Rounds", @"16 Rounds"];
        self.roundValues = @[@4, @6, @8, @10, @12, @14, @16];
        self.selectedRounds = [self.roundValues[4] intValue];
        self.defaultRow = 4;
        self.salts = [self restoreSalts];
    }
    return self;
}

- (DHRoundsPickerHandler*)initWithDelegate:(id<DHRoundsPickerDelegate>)delegate
{
    self = [self init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (NSString*)getCurrentSalt
{
    return [self.salts objectForKey:[NSString stringWithFormat:@"%d", self.selectedRounds]];
}

- (void)saveSalt:(NSString*)salt ForRounds:(int)rounds
{
    [self.salts setObject:salt forKey:[NSString stringWithFormat:@"%d", rounds]];
    [self persistSalts:self.salts];
}

#pragma mark - Persistance

- (void)persistSalts:(NSDictionary*)salts
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    
    if ([paths count] > 0) {
        
        NSString* dictPath = [[paths objectAtIndex:0]
                               stringByAppendingPathComponent:@"salts.dictionary"];
        [salts writeToFile:dictPath atomically:YES];
    }
}

- (NSMutableDictionary*)restoreSalts
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    
    NSMutableDictionary* result = [NSMutableDictionary dictionary];
    
    if ([paths count] > 0) {
        
        NSString* dictionaryPath = [[paths objectAtIndex:0]
                               stringByAppendingPathComponent:@"salts.dictionary"];
        [result addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:dictionaryPath]];
    }
    
    return result;
}

#pragma mark - PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return self.roundNames.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.roundNames[row];
}

#pragma mark - PickerView Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.selectedRounds = [self.roundValues[row] intValue];
    NSString* salt = [self.salts objectForKey:[NSString stringWithFormat:@"%d", self.selectedRounds]];
    [self.delegate selectedRounds:self.selectedRounds WithSalt:salt];
}

@end
