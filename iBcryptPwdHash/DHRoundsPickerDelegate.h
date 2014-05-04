//
//  DHRoundsPickerDelegate.h
//  iBcryptPwdHash
//
//  Created by Daniel Hjort on 5/4/14.
//  Copyright (c) 2014 Daniel Hjort. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DHRoundsPickerDelegate <NSObject>

- (void)selectedRounds:(int)rounds WithSalt:(NSString*)salt;

@end
