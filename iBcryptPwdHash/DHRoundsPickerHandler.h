//
//  DHRoundsPickerController.h
//  iBcryptPwdHash
//
//  Created by Daniel Hjort on 5/4/14.
//  Copyright (c) 2014 Daniel Hjort. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DHRoundsPickerDelegate;

@interface DHRoundsPickerHandler : NSObject <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *roundNames;
@property (strong, nonatomic) NSArray *roundValues;
@property (strong, nonatomic) NSMutableDictionary *salts;
@property (weak, nonatomic) id<DHRoundsPickerDelegate> delegate;

@property int selectedRounds;
@property int defaultRow;

- (DHRoundsPickerHandler*)initWithDelegate:(id<DHRoundsPickerDelegate>)delegate;

- (NSString*)getCurrentSalt;

- (void)saveSalt:(NSString*)salt ForRounds:(int)rounds;

@end
