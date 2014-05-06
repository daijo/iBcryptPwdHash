//
//  DHPickerViewController.m
//  iBcryptPwdHash
//
//  Created by Daniel Hjort on 5/5/14.
//  Copyright (c) 2014 Daniel Hjort. All rights reserved.
//

#import "DHPickerViewController.h"

@interface DHPickerViewController ()

@end

@implementation DHPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.preferredContentSize = CGSizeMake(320, 216);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addPickerHandler:(NSObject <UIPickerViewDelegate, UIPickerViewDataSource>*)handler
{
    self.picker.delegate = handler;
    self.picker.dataSource = handler;
}

@end
