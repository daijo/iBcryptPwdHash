//
//  DHPickerViewController.h
//  iBcryptPwdHash
//
//  Created by Daniel Hjort on 5/5/14.
//  Copyright (c) 2014 Daniel Hjort. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHPickerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIPickerView* picker;

- (void)addPickerHandler:(NSObject <UIPickerViewDelegate, UIPickerViewDataSource>*)handler;

@end
